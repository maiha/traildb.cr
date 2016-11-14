record TrailDB::Trail,
  index : Int32,
  uuid  : UUID do

  def hexuuid : String
    uuid.to_slice.hexstring
  end
end
