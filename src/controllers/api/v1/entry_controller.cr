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

      def create
        entry = Entry.new(entry_create_params.validate!)
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

      private def entry_create_params
        params.validation do
          required :device { |param| !param.nil? }
          required :date_string { |param| !param.nil? }
          required :sgv { |param| !param.nil? }
          required :delta { |param| !param.nil? }
          required :direction { |param| !param.nil? }
          required :filtered { |param| !param.nil? }
          required :unfiltered { |param| !param.nil? }
          required :rssi { |param| !param.nil? }
          required :noise { |param| !param.nil? }
          required :sys_time { |param| !param.nil? }
        end
      end

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
