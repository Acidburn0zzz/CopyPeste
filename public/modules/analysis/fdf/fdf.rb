# -*- coding: utf-8 -*-

# FDF V1.3

fdfAnalysisModule do
  description {
    "This is an analysis module for CopyPeste."
  }

  author { "Team Algo" }

  usage { 'Just run it!' }

  init { Fdf.new() }

  impl {
    require 'json'
    require File.join(CopyPeste::Require::Path.base, 'algorithms')
    require File.join(CopyPeste::Require::Path.algorithms, 'sort_file')
    require File.join(CopyPeste::Require::Path.copy_peste, 'DbHdlr')
    require File.join(CopyPeste::Require::Path.analysis, 'fdf', 'use_levenshtein')
    require File.join(CopyPeste::Require::Path.analysis, 'fdf', 'config_handler', 'Ignored_class')
    
    class Fdf
      attr_accessor :options
      attr_accessor :show
      

      def initialize
        @options = {
          "e" => {
            helper: "sort by extension.",
            allowed: [0, 1],
            value: 1
          },
          "s" => {
            helper: "sort by size.",
            allowed: [0, 1],
            value: 1
          },
          "p" => {
            helper: "minimum percentage of similarity between 2 files",
            allowed: [*60..100],
            value: 100
          }
        }
        @mongo = DbHdlr.new()
        @c_res = "Scoring"
        @c_file = "Fichier"
        @results = {
          module: "FDF",
          options: "List of duplicated files",
          timestamp: Time.now.getutc,
          type: "array",
          header: ["first", "second", "score"],
          references: [@c_file, @c_file, nil],
          transformation: [],
          rows: []
        }
        @ignored_conf = Ignored_class.new()
      end


      # Look at the different rules and chose the right way to sort files
      #
      # @param [Array] Array of files to sort
      # @Return [Hash] return an hash of all the files sorted
      def sort_files_with_rules(files)
        fichier = SortFile.new()
        files.each do |file|
          extension = fichier.get_extension file[:path]
          if @options["e"][:value] == 0 && @options["s"][:value] == 0
            fichier.sort_no_rulls file[:path]
          elsif @options["e"][:value] == 1 && @options["s"][:value] == 1
            fichier.sort_by_extension_and_size(file[:path], extension, file[:size])
          elsif @options["s"][:value] == 1
            fichier.sort_by_size(file[:path], file[:size])
          else
            fichier.sort_by_extension(file[:path], extension)
          end
        end
        fichier.get_hash()
      end


      # Extract path and name of each files and concat them.
      #
      # @param [Array][Array][Hash] take an Array of Array of hash. [files by extension][one file][hash of the file]
      # @Return [Array] return a file array with their full path and size
      def sort_tab(documents)
        files = []
        documents.each do |data|
          data.each do |file|
            files << {
              path: file["path"] + "/" + file["name"],
              size: file["size"]
            }
          end
        end
        files
      end


      # Get files from the database that will be analysed
      #
      # @Return [Array] return a file Array with the full file path :  Array[0] = /home/test/expemple.c
      def get_doc_to_analyse
        query = {name: {"$nin" => @ignored_conf.ignored_ext}}
        documents = []
        # puts @ignored_conf.ignored_ext
        results = @mongo.get_data("Extension", query, nil)
        #results = @mongo.get_data("Extension", query, nil)
        results.each do |data|
          data = JSON.parse data.to_json
          data["_id"] = BSON::ObjectId.from_string data["_id"]["$oid"]
          documents << @mongo.get_data(@c_file, {ext: data["_id"], name: {"$nin" => @ignored_conf.ignored_files }})
          #documents << @mongo.get_data(@c_file, {ext: data["_id"]})
        end
        sort_tab documents
      end


      # Save pair of file compared by fdupes/levenshtein, and there result
      # This Hash is saved in an Array
      #
      # @param [Hash] files and distance between their titles
      # @param [Int] result of comparison algorim
      # @return
      def save_result_data(file_d, similarity)
        result_data = [
          file_d[:files][0], #first file
          file_d[:files][1], #second file
          similarity #their similarity score
        ]
        @results[:rows] << result_data
      end


      # Open the two files and send there containt to fdupes algorithm
      #
      # @param [Array] File Array
      # @param [Integer] Loop position
      # @return [Integer] Return the percentage of difference between files
      def open_and_send(files_d)
        begin
          file1 = IO.read files_d[:files][0]
          file2 = IO.read files_d[:files][1]
        rescue => e # file doesn't exists, db have to be updated
          @show.call "[Error]: #{e} Please update your database"
          return nil
        end
        begin
          # if 100% similarity and files have the same size
          if @options["p"][:value] == 100 && (File.size(files_d[:files][0]) == File.size(files_d[:files][1]))
            Algorithms.fdupes_match(file1, file1.length, file2, file2.length)
          else
            Algorithms.diff(file1, file2)
          end
        rescue => e
          @show.call "[Not treated]: #{files_d[:files][0]} & #{files_d[:files][0]}: #{e}"
        end
      end


      # Send files to the fdupes algorithms
      # 
      # @param [Array] File array containing levenshtein's results
      # @Return
      def check_files_similarity(files_d)
        files_d.each do |file_d| #test
	# check if file has extension to be ignored	
          result = open_and_send file_d
          if result && ((@options["p"][:value] == 100 && result == 0) || result >= @options["p"][:value])
            save_result_data(file_d, result)
          end
        end
      end


      # Function used to initialize and run the fdf
      # and get the list of file to analyse.
      def run
        @show.call "Get all files from database..."
        files = get_doc_to_analyse
        @show.call "Done."
        @show.call "Sort files depending on options..."
        file_hash = sort_files_with_rules files
        @show.call "Done."
        @show.call "Searching for interesting files to analyse..."
        lev = UseLevenshtein.new(file_hash)
        files_d = lev.results
        @show.call "Done."
        if files_d.empty?
          @show.call "No file to analyse"
        else
          @show.call "Searching for duplicate files..."
          check_files_similarity files_d
          @show.call "Done."
          @show.call "Saving analyse results in database..."
          @mongo.ins_data(@c_res, @results);
          @show.call "Done, everything worked fine!"
          @show.call "You can now run generate_result to extract interesting informations."
        end
      end
    end
  }
end
