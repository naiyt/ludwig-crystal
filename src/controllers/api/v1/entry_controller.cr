module Api
  module V1
    class EntryController < ApplicationController
      def index
        respond_with do
          json({ thing: "stuff" }.to_json)
        end
      end

      def show
      end

      def create
        entry = Entry.new(entry_params.validate!)
        if entry.valid? && entry.save
          respond_with { json(entry.to_json) }
        else
          errors = entry.errors.map { |e| e.to_s }.join(", ")
          respond_with(400) { json({ success: false, errors: errors }.to_json) }
        end
      end

      def update
      end

      def destroy
      end

      private def entry_params
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
    end
  end
end
