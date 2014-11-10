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
      DateTime.strptime(date, '%Y-%m-%d %H:%M')
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
