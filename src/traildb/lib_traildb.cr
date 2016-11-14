@[Link("traildb")]
lib LibTraildb
  alias MultiCursor = Void
  fun item_field = tdb_item_field(item : Item) : Field
  alias Uint64T = LibC::ULong
  alias Item = Uint64T
  alias Uint32T = LibC::UInt
  alias Field = Uint32T
  fun item_val = tdb_item_val(item : Item) : Val
  alias Val = Uint64T
  fun make_item = tdb_make_item(field : Field, val : Val) : Item
  fun cons_init = tdb_cons_init : TdbCons
  type TdbCons = Void*
  fun cons_open = tdb_cons_open(cons : TdbCons, root : LibC::Char*, ofield_names : LibC::Char**, num_ofields : Uint64T) : Error
  enum Error
    TdbErrOk = 0
    TdbErrNomem = -2
    TdbErrPathTooLong = -3
    TdbErrUnknownField = -4
    TdbErrUnknownUuid = -5
    TdbErrInvalidTrailId = -6
    TdbErrHandleIsNull = -7
    TdbErrHandleAlreadyOpened = -8
    TdbErrUnknownOption = -9
    TdbErrInvalidOptionValue = -10
    TdbErrInvalidUuid = -11
    TdbErrIoOpen = -65
    TdbErrIoClose = -66
    TdbErrIoWrite = -67
    TdbErrIoRead = -68
    TdbErrIoTruncate = -69
    TdbErrIoPackage = -70
    TdbErrInvalidInfoFile = -129
    TdbErrInvalidVersionFile = -130
    TdbErrIncompatibleVersion = -131
    TdbErrInvalidFieldsFile = -132
    TdbErrInvalidUuidsFile = -133
    TdbErrInvalidCodebookFile = -134
    TdbErrInvalidTrailsFile = -135
    TdbErrInvalidLexiconFile = -136
    TdbErrInvalidPackage = -137
    TdbErrTooManyFields = -257
    TdbErrDuplicateFields = -258
    TdbErrInvalidFieldname = -259
    TdbErrTooManyTrails = -260
    TdbErrValueTooLong = -261
    TdbErrAppendFieldsMismatch = -262
    TdbErrLexiconTooLarge = -263
    TdbErrTimestampTooLarge = -264
    TdbErrTrailTooLong = -265
    TdbErrOnlyDiffFilter = -513
    TdbErrNoSuchItem = -514
  end
  fun cons_close = tdb_cons_close(cons : TdbCons)
  fun cons_set_opt = tdb_cons_set_opt(cons : TdbCons, key : OptKey, value : OptValue) : Error
  enum OptKey
    TdbOptOnlyDiffItems = 100
    TdbOptEventFilter = 101
    TdbOptCursorEventBufferSize = 102
    TdbOptConsOutputFormat = 1001
  end
  union OptValue
    ptr : Void*
    value : Uint64T
  end
  fun cons_get_opt = tdb_cons_get_opt(cons : TdbCons, key : OptKey, value : OptValue*) : Error
  fun cons_add = tdb_cons_add(cons : TdbCons, uuid : Uint8T[16], timestamp : Uint64T, values : LibC::Char**, value_lengths : Uint64T*) : Error
  alias Uint8T = UInt8
  fun cons_append = tdb_cons_append(cons : TdbCons, db : Tdb) : Error
  type Tdb = Void*
  fun cons_finalize = tdb_cons_finalize(cons : TdbCons) : Error
  fun init = tdb_init : Tdb
  fun open = tdb_open(db : Tdb, root : LibC::Char*) : Error
  fun close = tdb_close(db : Tdb)
  fun dontneed = tdb_dontneed(db : Tdb)
  fun willneed = tdb_willneed(db : Tdb)
  fun num_trails = tdb_num_trails(db : Tdb) : Uint64T
  fun num_events = tdb_num_events(db : Tdb) : Uint64T
  fun num_fields = tdb_num_fields(db : Tdb) : Uint64T
  fun min_timestamp = tdb_min_timestamp(db : Tdb) : Uint64T
  fun max_timestamp = tdb_max_timestamp(db : Tdb) : Uint64T
  fun version = tdb_version(db : Tdb) : Uint64T
  fun error_str = tdb_error_str(errcode : Error) : LibC::Char*
  fun set_opt = tdb_set_opt(db : Tdb, key : OptKey, value : OptValue) : Error
  fun get_opt = tdb_get_opt(db : Tdb, key : OptKey, value : OptValue*) : Error
  fun lexicon_size = tdb_lexicon_size(db : Tdb, field : Field) : Uint64T
  fun get_field = tdb_get_field(db : Tdb, field_name : LibC::Char*, field : Field*) : Error
  fun get_field_name = tdb_get_field_name(db : Tdb, field : Field) : LibC::Char*
  fun get_item = tdb_get_item(db : Tdb, field : Field, value : LibC::Char*, value_length : Uint64T) : Item
  fun get_value = tdb_get_value(db : Tdb, field : Field, val : Val, value_length : Uint64T*) : LibC::Char*
  fun get_item_value = tdb_get_item_value(db : Tdb, item : Item, value_length : Uint64T*) : LibC::Char*
  fun get_uuid = tdb_get_uuid(db : Tdb, trail_id : Uint64T) : Uint8T*
  fun get_trail_id = tdb_get_trail_id(db : Tdb, uuid : Uint8T[16], trail_id : Uint64T*) : Error
  fun uuid_raw = tdb_uuid_raw(hexuuid : Uint8T[32], uuid : Uint8T[16]) : Error
  fun uuid_hex = tdb_uuid_hex(uuid : Uint8T[16], hexuuid : Uint8T[32])
  alias EventFilter = Void
  fun event_filter_new = tdb_event_filter_new : EventFilter*
  fun event_filter_add_term = tdb_event_filter_add_term(filter : EventFilter*, term : Item, is_negative : LibC::Int) : Error
  fun event_filter_new_clause = tdb_event_filter_new_clause(filter : EventFilter*) : Error
  fun event_filter_free = tdb_event_filter_free(filter : EventFilter*)
  fun event_filter_get_item = tdb_event_filter_get_item(filter : EventFilter*, clause_index : Uint64T, item_index : Uint64T, item : Item*, is_negative : LibC::Int*) : Error
  fun event_filter_num_clauses = tdb_event_filter_num_clauses(filter : EventFilter*) : Uint64T
  fun cursor_new = tdb_cursor_new(db : Tdb) : Cursor*
  struct Cursor
    state : Void*
    next_event : LibC::Char*
    num_events_left : Uint64T
  end
  fun cursor_free = tdb_cursor_free(cursor : Cursor*)
  fun get_trail = tdb_get_trail(cursor : Cursor*, trail_id : Uint64T) : Error
  fun get_trail_length = tdb_get_trail_length(cursor : Cursor*) : Uint64T
  fun cursor_set_event_filter = tdb_cursor_set_event_filter(cursor : Cursor*, filter : EventFilter*) : Error
  fun cursor_unset_event_filter = tdb_cursor_unset_event_filter(cursor : Cursor*)
  fun multi_cursor_new = tdb_multi_cursor_new(cursors : Cursor**, num_cursors : Uint64T) : TdbMultiCursor
  type TdbMultiCursor = Void*
  fun multi_cursor_reset = tdb_multi_cursor_reset(mc : TdbMultiCursor)
  fun multi_cursor_next = tdb_multi_cursor_next(mcursor : TdbMultiCursor) : MultiEvent*
  struct MultiEvent
    db : Tdb
    event : Event*
    cursor_idx : Uint64T
  end
  struct Event
    timestamp : Uint64T
    num_items : Uint64T
    items : Item[0]
  end
  fun multi_cursor_next_batch = tdb_multi_cursor_next_batch(mcursor : TdbMultiCursor, events : MultiEvent*, max_events : Uint64T) : Uint64T
  fun multi_cursor_peek = tdb_multi_cursor_peek(mcursor : TdbMultiCursor) : MultiEvent*
  fun multi_cursor_free = tdb_multi_cursor_free(mcursor : TdbMultiCursor)
  fun cursor_next = tdb_cursor_next(cursor : Cursor*) : Event*
  fun cursor_peek = tdb_cursor_peek(cursor : Cursor*) : Event*
end

