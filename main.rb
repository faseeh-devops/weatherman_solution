# frozen_string_literal: true

require_relative 'main_calculations'
require_relative 'line_colors'

# Code Running Class
class Main
  include LineColors
  choice = ARGV[0]
  date = ARGV[1].split('/')
  location = ARGV[2]

  calculation = Calculation.new

  case choice
  when '-e'
    solution = calculation.high_low(calculation.fetch_files_to_read(date[0], 'by_year', location, Dir["#{location}/*"]))
    puts "Year: #{date[0]}"
    puts "Highest: #{solution[0]['temp']}C on #{solution[0]['day']} #{solution[0]['date']}"
    puts "Lowest: #{solution[1]['temp']}C on #{solution[1]['day']} #{solution[1]['date']}"
    puts "Humid: #{solution[2]['humidity']}% on #{solution[2]['day']} #{solution[2]['date']}"


  when '-a'
    solution = calculation.avg_data(calculation.fetch_files_to_read(date[0], 'by_month', location,
                                                                    Dir["#{location}/*"]))

    puts "Year: #{date[0]} Month: #{date[1]}"
    puts "Highest Average: #{solution[0]}C"
    puts "Lowest Average: #{solution[1]}C"
    puts "Average Humidity: #{solution[2]}%"

  when '-b'
    solution = calculation.each_date(calculation.fetch_files_to_read(date[0], 'by_month', location, Dir["#{location}/*"]))
    solution.each do |key, value|
      print key.to_s
      value[1].to_i.times do
        print '+'.blue
      end
      value[0].to_i.times do
        print '+'.red
      end
      print " #{value[1]}C - #{value[0]}C\n"
    end


  end


end
