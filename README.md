# traildb.cr

TrailDB bindings for [Crystal](http://crystal-lang.org/).

Check [traildb](https://github.com/traildb/traildb) for general db driver documentation.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  traildb:
    github: maiha/traildb.cr
```

## Usage

#### low level api

use `LibTraildb` as you like for a shin wrapper of C library

```crystal
require "traildb"

cons = LibTraildb.cons_init
```

- see [src/lib_traildb.cr](src/lib_traildb.cr)

#### high level api

- use `TrailDB.create` for constructor
- use `TrailDB.open` for tdb reader
- still in progress

```crystal
require "traildb"

TrailDB.create("tiny", ["username", "action"]) do |db|
  uuid = "1000000000000000"
  timestamp = Time.now.epoch
  db.add(uuid, timestamp, ["maiha", "login"])
end
```

```shell
% tdb dump -i tiny
31303030303030303030303030303030 1479320076 maiha login
```

## Roadmap

#### 0.1.0 : low level api

- [x] `LibTraildb`

#### 0.2.0 : high level api

- [x] `TrailDB::Constructor`
- [ ] `TrailDB::TDB`

## Contributing

1. Fork it ( https://github.com/maiha/traildb.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [maiha](https://github.com/maiha) maiha - creator, maintainer
