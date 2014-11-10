module KLRSParser
  class TimeValue
    attr_reader :time, :value

    def initialize(timestamp, value)
      @time = timestamp
      @value = value
    end
  end
end
