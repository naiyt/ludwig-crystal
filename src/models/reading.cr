class Reading < Granite::Base
  adapter pg
  table_name readings

  primary id : Int64
  field value : Int32
  timestamps
end
