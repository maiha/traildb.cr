class TrailDB::TDB
  include Check

  def self.open(name : String)
    new(name)
  end

  def self.open(name : String)
    tdb = new(name)
    yield(tdb)
  ensure
    tdb.try(&.close)
  end

  def initialize(@name : String)
    @tdb = LibTraildb.init
    @connected = true
    check api.open(@tdb, name)
  end

  def each
    (0 ... api.num_trails(@tdb)).each do |i|
      #const tdb_event *event;
      #uint8_t [32];
#      hexuuid = StaticArray(UInt8, 32).new {|i| 0_u8 }
      uuid = api.get_uuid(@tdb, i)
      #      api.uuid_hex(TrailDB.sa16(uuid), hexuuid)
      trail = Trail.new(i, TrailDB.sa16(uuid))
      #      tdb_get_trail(cursor, i);
      yield(trail)
    end
  end

  def close
    if @connected
      check api.close(@tdb)
      @connected = false
    end
  end

  private def api
    LibTraildb
  end
end
