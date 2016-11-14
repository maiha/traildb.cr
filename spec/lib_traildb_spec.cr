require "./spec_helper"

# http://traildb.io/docs/tutorial/

describe "(low level api)" do
  it "Create a new TrailDB constructor" do
    fields = Pointer(Pointer(UInt8)).malloc(2_u64)
    fields.value = "username".to_unsafe
    (fields + 1_u64).value = "action".to_unsafe
    cons = LibTraildb.cons_init
    err = LibTraildb.cons_open(cons, "tiny", fields, 2)
    err.should eq(LibTraildb::Error::TdbErrOk)
  end
end
