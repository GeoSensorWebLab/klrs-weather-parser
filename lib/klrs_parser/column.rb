module KLRSParser
  class Column
    require 'csv'

    attr_accessor :name, :units, :stats
    attr_reader :data

    def initialize(name, units = "", stats = "")
      @name = name
      @units = units
      @stats = stats
      @data = []
    end

    def << time_value
      @data.push(time_value)
    end
  end
end
