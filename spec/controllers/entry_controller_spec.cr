require "./spec_helper"

def entry_hash
  {"device" => "Fake", "date_string" => "2018-11-27 14:53:27 -07:00", "sgv" => "1", "delta" => "1.00", "direction" => "Fake", "filtered" => "1", "unfiltered" => "1", "rssi" => "1", "noise" => "1", "sys_time" => "2018-11-27 14:53:27 -07:00"}
end

def entry_params
  params = [] of String
  params << "device=#{entry_hash["device"]}"
  params << "date_string=#{entry_hash["date_string"]}"
  params << "sgv=#{entry_hash["sgv"]}"
  params << "delta=#{entry_hash["delta"]}"
  params << "direction=#{entry_hash["direction"]}"
  params << "filtered=#{entry_hash["filtered"]}"
  params << "unfiltered=#{entry_hash["unfiltered"]}"
  params << "rssi=#{entry_hash["rssi"]}"
  params << "noise=#{entry_hash["noise"]}"
  params << "sys_time=#{entry_hash["sys_time"]}"
  params.join("&")
end

def create_entry
  model = Entry.new(entry_hash)
  model.save
  model
end

class EntryControllerTest < GarnetSpec::Controller::Test
  getter handler : Amber::Pipe::Pipeline

  def initialize
    @handler = Amber::Pipe::Pipeline.new
    @handler.build :web do
      plug Amber::Pipe::Error.new
      plug Amber::Pipe::Session.new
      plug Amber::Pipe::Flash.new
    end
    @handler.prepare_pipelines
  end
end

describe EntryControllerTest do
  subject = EntryControllerTest.new

  it "renders entry index template" do
    Entry.clear
    response = subject.get "/entries"

    response.status_code.should eq(200)
    response.body.should contain("entries")
  end

  it "renders entry show template" do
    Entry.clear
    model = create_entry
    location = "/entries/#{model.id}"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Show Entry")
  end

  it "renders entry new template" do
    Entry.clear
    location = "/entries/new"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("New Entry")
  end

  it "renders entry edit template" do
    Entry.clear
    model = create_entry
    location = "/entries/#{model.id}/edit"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Edit Entry")
  end

  it "creates a entry" do
    Entry.clear
    response = subject.post "/entries", body: entry_params

    response.headers["Location"].should eq "/entries"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "updates a entry" do
    Entry.clear
    model = create_entry
    response = subject.patch "/entries/#{model.id}", body: entry_params

    response.headers["Location"].should eq "/entries"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "deletes a entry" do
    Entry.clear
    model = create_entry
    response = subject.delete "/entries/#{model.id}"

    response.headers["Location"].should eq "/entries"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end
end
