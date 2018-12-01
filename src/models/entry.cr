class Entry < Granite::Base
  adapter pg
  table_name entries

  primary id : Int64
  field! device : String
  field! date_string : String
  field! sgv : Int32
  field delta : Float64
  field! direction : String
  field filtered : Int32
  field unfiltered : Int32
  field rssi : Int32
  field noise : Int32
  field sys_time : String
  timestamps

  FLAT          = "Flat"
  FORTYFIVEDOWN = "FortyFiveDown"
  FORTYFIVEUP   = "FortyFiveUp"
  SINGLEUP      = "SingleUp"
  SINGLEDOWN    = "SingleDown"
  DOUBLEDOWN    = "DoubleDown"
  NOTCOMPUTABLE = "NOT COMPUTABLE"
  VALID_DIRECTIONS = { FLAT, FORTYFIVEDOWN, FORTYFIVEDOWN, FORTYFIVEUP, SINGLEUP, SINGLEDOWN, DOUBLEDOWN, NOTCOMPUTABLE }

  validate :direction, "inclusion of" do |entry|
     VALID_DIRECTIONS.includes? entry.direction
  end
end
