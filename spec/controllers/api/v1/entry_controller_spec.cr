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
end
