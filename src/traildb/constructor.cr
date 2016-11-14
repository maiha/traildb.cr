class TrailDB::Constructor
  include Check
  
  def initialize(@root : String, @fields : Array(String))
    @cons = LibTraildb.cons_init
    unless @cons
      raise "failed to init TrailDB"
    end
    @connected = true
    check api.cons_open(@cons, @root, TrailDB.fields(@fields), @fields.size)
  end

  def get_opt_output_format
    get_opt(LibTraildb::OptKey::TdbOptConsOutputFormat)
  end

  def get_opt(key)
    LibTraildb::OptKey::TdbOptConsOutputFormat
    ptr = Pointer(LibTraildb::OptValue).malloc(1_u64)
    check api.cons_get_opt(@cons, key, ptr)
    return ptr.as(Pointer(UInt64)).value
  end
  
  # fun cons_add = tdb_cons_add(cons : TdbCons, uuid : Uint8T[16], timestamp : Uint64T, values : LibC::Char**, value_lengths : Uint64T*) : Error
  def add(uuid, timestamp, values)
    uuid = TrailDB.uuid(uuid)
    vals = TrailDB.fields(values)
    lens = TrailDB.lengths(values)
    check api.cons_add(@cons, uuid, timestamp, vals, lens)
  end

  def close
    if @connected
      check api.cons_close(@cons)
      @connected = false
    end
  end

  def finalize
    check api.cons_finalize(@cons)
  end

  private def api
    LibTraildb
  end
end
