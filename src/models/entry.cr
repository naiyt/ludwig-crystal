class Entry < Granite::Base
  adapter pg
  table_name entries

  primary id : Int64
  field device : String
  field date_string : Time
  field sgv : Int32
  field delta : Float32
  field direction : String
  field filtered : Int32
  field unfiltered : Int32
  field rssi : Int32
  field noise : Int32
  field sys_time : Time
  timestamps
end
