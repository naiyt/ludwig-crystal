require "../../spec_helper"

class Api::V1::EntryControllerTest < GarnetSpec::Controller::Test
  getter handler : Amber::Pipe::Pipeline

  def initialize
    @handler = Amber::Pipe::Pipeline.new
    @handler.build :api_v1 do
      plug Amber::Pipe::Error.new
      plug Amber::Pipe::Session.new
      plug Amber::Pipe::Flash.new
    end
    @handler.prepare_pipelines
  end
end

def valid_create_attributes
  {
    "device" => "Nexus 5X",
    "date_string" => Time.now.to_s,
    "sgv" => 110,
    "delta" => 12.0,
    "direction" => Entry::FORTYFIVEUP,
    "filtered" => 100,
    "unfiltered" => 100,
    "rssi" => 100,
    "noise" => 1,
    "sysTime" => Time.now.to_s,
  }
end

def validate_create_params(params=valid_create_attributes)
  # TODO: this is annoying, but xDrip+ and Nightscout call the column dateString,
  # but that gives me issues because Postgres is case insensitive, and then amber
  # freaks out if the field is called dateString, since the database reports
  # datestring.
  params["dateString"] = params["date_string"]
  "_json=#{params.to_json}"
end

def create_entry
  entry = Entry.new(valid_create_attributes)
  entry.save!
  entry
end

describe Api::V1::EntryControllerTest do
  subject = Api::V1::EntryControllerTest.new

  describe "#GET index" do
    it "retrieves a paginated list of entries" do
      Entry.clear
      response = subject.get("/api/v1/entries")
      response.status_code.should eq(200)
      body = JSON.parse(response.body)
      body["thing"].should eq("stuff")
    end
  end

  describe "#GET show" do
    it "returns the specified entry" do
      entry = create_entry
      response = subject.get("/api/v1/entries/#{entry.id}")
      response.status_code.should eq(200)
      JSON.parse(response.body)["id"].should eq(entry.id)
    end
  end

  describe "#POST create" do
    it "creates the entry" do
      Entry.clear
      before_count = Entry.count
      response = subject.post("/api/v1/entries", body: validate_create_params)
      response.status_code.should eq(200)
      Entry.count.should eq(before_count + 1)
    end
  end

  describe "#DELETE destroy" do
    it "destroys the entry" do
      Entry.clear
      entry = create_entry
      before_count = Entry.count
      response = subject.delete("/api/v1/entries/#{entry.id}")
      response.status_code.should eq(200)
      Entry.count.should eq(before_count - 1)
      Entry.find(entry.id).should eq(nil)
    end
  end
end
