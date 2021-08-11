require 'csv'
require_relative 'fetch_files'
# Class which performs all calculations
class Calculation
  include FetchFilesToRead
  def each_date(filename)
    dict = {}
    data = CSV.read(filename.to_s)
    data.each_with_index do |val, index|
      row = val.flatten
      next if (index <= 1) || (index == (data.length - 1))

      day = DateTime.parse(row[0]).strftime('%d')
      dict[day] = [row[1].to_i, row[3].to_i] unless row[1].empty? && row[3].to_s.empty?


    end
    dict
  end

  def high_low(files_array)
    highest_temp = { 'temp' => 0, 'day' => 'None', 'date' => 0 }
    lowest_temp = { 'temp' => 100, 'day' => 'None', 'date' => 0 }
    humidity = { 'humidity' => 0, 'day' => 'None', 'date' => 0 }

    files_array.each do |file|
      data = CSV.read(file)
      data.each_with_index do |value, index|
        row = value.flatten
        next if (index <= 1) || (index == (data.length - 1))

        month = DateTime.parse(row[0]).strftime('%B')
        day = DateTime.parse(row[0]).strftime('%d')

        if !row[1].to_s.empty? && (highest_temp['temp'].to_i < row[1].to_i)

          highest_temp['temp'] = row[1].to_i
          highest_temp['date'] = day.to_i
          highest_temp['day'] = month.to_s
        end
        if !row[3].to_s.empty? && (lowest_temp['temp'].to_i > row[3].to_i)

          lowest_temp['temp'] = row[3].to_i
          lowest_temp['date'] = day.to_i
          lowest_temp['day'] = month.to_s
        end
        next unless !row[7].to_s.empty? && (humidity['humidity'].to_i < row[7].to_i)

        humidity['humidity'] = row[7].to_i
        humidity['date'] = day.to_i
        humidity['day'] = month.to_s


      end
    end
    [highest_temp, lowest_temp, humidity]
  end

  def avg_data(filename)
    hi_temp_sum = 0, low_temp_sum = 0, humidity_sum = 0, hi_count = 0, lo_count = 0, hum_count = 0
    data = CSV.read(filename)
    data.each_with_index do |val, index|
      row = val.flatten
      next if (index <= 1) || (index == (data.length - 1))

      unless row[1].to_s.empty?
        hi_temp_sum += row[1].to_i
        hi_count = hi_count.next
      end
      unless row[3].to_s.empty?
        low_temp_sum += row[3].to_i
        lo_count = lo_count.next
      end
      unless row[8].to_s.empty?
        humidity_sum += row[8].to_i
        hum_count = hum_count.next
      end

    end

    hi_temp_avg = hi_temp_sum/hi_count
    low_temp_avg = low_temp_sum/lo_count
    hum_avg = humidity_sum/hum_count
    [hi_temp_avg, low_temp_avg, hum_avg]
  end




end
