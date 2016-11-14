module TrailDB
  def self.uuid(value : UUID)
    value
  end

  def self.uuid(value)
    value = value.to_s
    if value.bytesize > 16
      raise "uuid bytes size expects 16, but got #{value.bytesize}. `#{value}'"
    end
    sa16(value.to_unsafe)
  end

  def self.sa16(ptr)
    StaticArray(UInt8, 16).new{|i| (ptr + i.to_u8).value}
  end

  def self.fields(strs)
    fields = Pointer(Pointer(UInt8)).malloc(strs.size.to_u64)
    strs.each_with_index do |str, i|
      (fields + i.to_u64).value = str.to_unsafe
    end
    return fields
  end

  def self.lengths(strs)
    lengths = Pointer(UInt64).malloc(strs.size.to_u64)
    strs.each_with_index do |str, i|
      (lengths + i.to_u64).value = str.bytesize.to_u64
    end
    return lengths
  end
end
