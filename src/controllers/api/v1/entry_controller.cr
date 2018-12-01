module Api
  module V1
    class EntryController < ApplicationController
      getter entry = Entry.new

      before_action do
        only [:show, :update, :destroy] { set_entry }
      end

      def index
        respond_with do
          json({ thing: "stuff" }.to_json)
        end
      end

      def show
        respond_with do
          json entry.to_json
        end
      end

      # Data should be posted in the following format:
      # {
      #   _json: {
      #     // json string with the permitted parameters
      #   }
      # }
      # A bit clumsy, but that's the format that Nightscout expects,
      # and what xDrip+ uses.
      def create
        parsed_params = JSON.parse(params.raw_params["_json"])
        entry = Entry.new(strong_params(parsed_params, ALLOWED_CREATE_PARAMS))
        if entry.valid? && entry.save
          respond_with { json entry.to_json }
        else
          error_response(entry)
        end
      end

      # TODO: updating is currently disabled, because the `optional` params validation is broken in amber.
      # Not sure if there's a good strong_params style alternative, so I'm just keeping this out for now.
      # There shouldn't generally be the need to update existing entries anyway.
      # def update
      # end

      def destroy
        entry.destroy!
        respond_with { json({ status: "successfully destroyed"}.to_json) }
      end

      private ALLOWED_CREATE_PARAMS = {
        "device" => "device",
        "dateString" => "date_string",
        "sgv" => "sgv",
        "delta" => "delta",
        "direction" => "direction",
        "filtered" => "filtered",
        "unfiltered" => "unfiltered",
        "rssi" => "rssi",
        "noise" => "noise",
        "sysTime" => "sys_time",
      }

      private def set_entry
        @entry = Entry.find!(params[:id])
      end

      private def error_response(entry : Entry)
        errors = entry.errors.map { |e| e.to_s }.join(", ")
        respond_with(400) { json({ success: false, errors: errors }.to_json) }
      end
    end
  end
end
