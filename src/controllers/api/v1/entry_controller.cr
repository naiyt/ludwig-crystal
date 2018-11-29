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
      end

      def update
      end

      def destroy
      end
    end
  end
end
