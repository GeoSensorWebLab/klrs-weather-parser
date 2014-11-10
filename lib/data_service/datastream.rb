module DataService
  class Datastream
    require 'securerandom'

    attr_reader :uid, :id, :unit, :phenName, :extra
    def initialize(id, unit, phenName, extra = {})
      @uid = SecureRandom.hex(16)
      @id = id
      @unit = unit
      @phenName = phenName
      @extra = extra
    end

    def to_hash
      @extra.merge({
        uid: @uid,
        id: @id,
        unit: @unit,
        phenName: @phenName
      })
    end
  end
end
