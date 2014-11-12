module DataService
  class Record
    require 'securerandom'

    attr_reader :uid, :id, :reading, :datetime, :extra
    def initialize(date, value, extra = {})
      @uid = SecureRandom.hex(16)
      @date = parse_date(date)

      @id = @date.strftime('%Y-%m-%dT%H:%M:%S')
      @reading = value
      @datetime = @date.strftime('%a %b %e %H:%M:%S %:z %Y')
      @extra = extra
    end

    def parse_date(date)
      if date ~= /\d+-\d+-\d+ \d{2}:\d{2}(\-|\+)\d+(:\d+)?(:\d+)?+/
        DateTime.strptime(date, '%Y-%m-%d %H:%M%z')
      elsif date ~= /\d+-\d+-\d+ \d{2}:\d{2}:\d{2}(\-|\+)\d+(:\d+)?(:\d+)?+/
        DateTime.strptime(date, '%Y-%m-%d %H:%M:%S%z')
      else
        raise "Unknown date format"
      end
    end

    def to_hash
      @extra.merge({
        uid: @uid,
        id: @id,
        reading: @reading,
        datetime: @datetime
      })
    end
  end
end
