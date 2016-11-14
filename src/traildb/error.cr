module TrailDB
  def self.error_str(err)
    String.new(LibTraildb.error_str(err))
  end
end
