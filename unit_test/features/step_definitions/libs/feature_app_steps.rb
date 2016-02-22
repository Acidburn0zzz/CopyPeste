# Libs App
Given /^step libs app loading$/ do

  Dir["./path_tests/libs/app/*.rb"].each do | file |
    puts "Steps file: " + File.basename(file)

    name_file = File.basename(file,File.extname(file))
    steps %{
        Given step #{name_file} loading
        When step #{name_file} checking
        Then step #{name_file} resulting
    }
    puts "--------"
  end
end
