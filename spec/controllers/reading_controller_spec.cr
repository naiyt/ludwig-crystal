require "./spec_helper"

def reading_hash
  {"value" => "1"}
end

def reading_params
  params = [] of String
  params << "value=#{reading_hash["value"]}"
  params.join("&")
end

def create_reading
  model = Reading.new(reading_hash)
  model.save
  model
end

class ReadingControllerTest < GarnetSpec::Controller::Test
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

describe ReadingControllerTest do
  subject = ReadingControllerTest.new

  it "renders reading index template" do
    Reading.clear
    response = subject.get "/readings"

    response.status_code.should eq(200)
    response.body.should contain("readings")
  end

  it "renders reading show template" do
    Reading.clear
    model = create_reading
    location = "/readings/#{model.id}"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Show Reading")
  end

  it "renders reading new template" do
    Reading.clear
    location = "/readings/new"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("New Reading")
  end

  it "renders reading edit template" do
    Reading.clear
    model = create_reading
    location = "/readings/#{model.id}/edit"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Edit Reading")
  end

  it "creates a reading" do
    Reading.clear
    response = subject.post "/readings", body: reading_params

    response.headers["Location"].should eq "/readings"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "updates a reading" do
    Reading.clear
    model = create_reading
    response = subject.patch "/readings/#{model.id}", body: reading_params

    response.headers["Location"].should eq "/readings"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "deletes a reading" do
    Reading.clear
    model = create_reading
    response = subject.delete "/readings/#{model.id}"

    response.headers["Location"].should eq "/readings"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end
end
