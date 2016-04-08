# -*- coding: utf-8 -*-

require_relative './collection'
require_relative '../../../libs/modules/analysis/sort_project'

class Sps
  attr_accessor :options
  

  def initialize(options)
    @options = options
    #@fichier = Collection.new("Fichier")
    #@duplicate = Collection.new("Duplicate")
    @hash_files = {}
    @hash_key = []
    @sort_project = SortProject.new()
  end
  

  def start
    get_file_from_db
  end
  

  private 
  

  def get_file_from_db
    @hash_files = {:files => ["/projet3/path1...etc", "/projet2/path2...etc",
                              "/projet1/path3...etc","/projet3/path4...etc",
                              "/projet2/path6...etc","/projet1/path5...etc",
                              "/projet1/path7...etc", ]}
    #@hash_files = @fichier.get_doc
    sort_file
    send_project_to_compare
  end
  

  def average(results)
    tmp = 0
    results.each do |nb|
      tmp = tmp + nb
    end
    @average_res = tmp/results.size()
  end

  def compare_project(p_1, p_2)
    size_p_1 = p_1.size()
    size_p_2 = p_2.size()
    results = []
    (0..size_p_1 - 1).each do |i|
      #file1 = IO.read(p_1[i])
      (0..size_p_2 - 1).each do |j|
        #file2 = IO.read(p_2[j])
        puts "file 1 : #{p_1[i]} compare with file 2 : #{p_2[j]}"
        #results << Algorithms.diff(file1, file2)
      end
    end
    results = [62, 15, 78, 14, 16, 18, 2, 6, 90, 50, 60, 5, 0, 78, 98, 100, 100, 4, 86]
    average(results)
  end

  
  def send_project_to_compare
    size = @hash_key.size()
    (0..size - 2).each do |i|
      (i+1..size - 1).each do |j|
        puts "\n#{@hash_key[i]} compare with #{@hash_key[j]}"
        compare_project(
          @hash_files["#{@hash_key[i]}"], 
          @hash_files["#{@hash_key[j]}"]
        )
        #save_in_db(@hash_key[i]}, @hash_key[j])
        puts "average = #{@average_res}"
      end
    end

  end

  
  def save_in_db(p_1, p_2)
    if @duplicate.is_in_db?({:project => [p_1, p_2]})
      @duplicate.update_doc({:project => [p_1, p_2], :average => @average_res})
    else
      @duplicate.add_doc({:project => [p_1, p_2], :average => @average_res})
    end
    
  end

  
  def sort_file
    tab_files = []
    @sort_project.sort_by_project(@hash_files)
    @hash_files = @sort_project.get_hash_sorted
    @hash_files.each_key do |key|
      @hash_key << key
    end
    puts @hash_files
  end
end
