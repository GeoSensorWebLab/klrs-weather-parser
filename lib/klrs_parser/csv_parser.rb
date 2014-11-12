module KLRSParser
  class CSVParser
    attr_reader :columns

    # Create a new CSV parser for File (IO Class). Options:
    #
    # * timezone (string): An offset to assume for the input data. Example is
    #                      "-07:00". Default is "+00:00" (UTC).
    #
    def initialize(file, options = {})
      @timezone = options[:timezone] || "+00:00"

      @columns = []
      @delimiter = find_delimiter(file.gets)
      parse_columns(file.gets)
      parse_units(file.gets)
      parse_stats(file.gets)
      parse_data(file)
    end

    # If there is more than one tab character in the line, it probably is TSV.
    def find_delimiter(line)
      if line.count("\t") > 1
        "\t"
      else
        ","
      end
    end

    private

    def parse_columns(line)
      names = CSV.parse(line, col_sep: @delimiter)[0]
      @columns = names.map do |name|
        Column.new(name)
      end
    end

    def parse_units(line)
      units = CSV.parse(line, col_sep: @delimiter)[0]
      units.each_with_index do |unit, i|
        column = @columns.at(i)
        column.units = unit if column
      end
    end

    def parse_stats(line)
      stats = CSV.parse(line, col_sep: @delimiter)[0]
      stats.each_with_index do |stat, i|
        column = @columns.at(i)
        column.stats = stat if column
      end
    end

    # Stream the remaining data for parsing as time/value data
    def parse_data(file)
      file.each_line do |line|
        parse_readings(CSV.parse(line, col_sep: @delimiter)[0])
      end
    end

    def parse_readings(readings)
      timestamp = readings.shift
      timestamp += @timezone
      readings.each_with_index do |reading, i|
        column = @columns.at(i+1)
        column << TimeValue.new(timestamp, reading) if column
      end
    end
  end
end
