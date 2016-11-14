module TrailDB
  def self.create(root : String, fields : Array(String))
    Constructor.new(root, fields)
  end

  def self.create(root : String, fields : Array(String))
    con = create(root, fields)
    yield(con)
  ensure
    con.try(&.finalize)
    con.try(&.close)
  end

  def self.open(file : String)
    TDB.new(file)
  end
  
  def self.open(file : String)
    tdb = open(file)
    yield(tdb)
  ensure
    tdb.try(&.close)
  end
end
