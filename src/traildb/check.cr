module Check
  protected def check(err)
    raise TrailDB.error_str(err) if err && err != LibTraildb::Error::TdbErrOk
    return err
  end
end
