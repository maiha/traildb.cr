require "./spec_helper"
require "file_utils"

# http://traildb.io/docs/tutorial/

describe "(high level api)" do
  db = TrailDB.create("tiny", ["message"])

  it "check default options" do
    db.get_opt_output_format.should eq(1)
  end

  it "Create a new TrailDB constructor" do
    # already created
  end

  it "Add events in the TrailDB" do
    # 10000000000000000000000000000000 1463696903 hello world
    # 20000000000000000000000000000000 1463696952 it works!
    uuid1 = TrailDB::UUID.new(0_u8)
    uuid2 = TrailDB::UUID.new(0_u8)

    uuid1[0] = 16_u8
    uuid2[0] = 32_u8
    
    db.add(uuid1, 1463696903, ["hello world"])
    db.add(uuid2, 1463696952, ["it works!"])
  end

  it "Finalize the TrailDB" do
    db.finalize
    db.close
  end

  it "delete tiny directory to read from package file" do
    # This is needed because tdb_open fails when directory exists.
    # -> TDB_ERR_INVALID_INFO_FILE
    #
    # I don't know why we must do this explicitly.
    FileUtils.rm_r("tiny") if File.directory?("tiny")
  end
  
  it "Print out contents of the new TrailDB" do
    # 10000000000000000000000000000000 1463696903 hello world
    # 20000000000000000000000000000000 1463696952 it works!
    tdb = TrailDB::TDB.open("tiny")
    tdb.each do |trail|
      case trail.index
      when 0
        trail.hexuuid.should eq("10000000000000000000000000000000")
      when 1
        trail.hexuuid.should eq("20000000000000000000000000000000")
      else
        fail "trail size is expected as 2, but got 3+"
      end
    end
    tdb.close
  end
end
