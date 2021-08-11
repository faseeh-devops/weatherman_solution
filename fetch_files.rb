# frozen_string_literal: true
# Module to fetch files from the provided directory
module FetchFilesToRead


  # @param [Object] year
  # @param [Integer] month
  # @param [Object] choice
  # @param [Object] folder
  # @param [Object] files_array
  # @return [Array]
  def fetch_files_to_read(year, choice, folder, files_array, month = 0)
    temporary_array = []
    files_array.each do |file|
      temporary_name = file.gsub(folder + '/'.to_s, '')
      temporary_name = temporary_name.split('_')
      case choice
      when 'by_year'
        temporary_array << file if temporary_name[2].to_i == year.to_i
      when 'by_month'
        if temporary_name[2].to_i == year.to_i && Date::ABBR_MONTHNAMES.index(temporary_name[3].split('.')[0]).to_i == month.to_i
          temporary_array << file
        end
      end

    end

    temporary_array


  end

  end
