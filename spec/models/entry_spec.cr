require "./spec_helper"
require "../../src/models/entry.cr"

describe Entry do
  Spec.before_each do
    Entry.clear
  end

  describe "validations" do
    describe "direction" do
      # Idea: shoulda-matchers port would be nice, but would probably rely on a better validation framework for
      # amber: https://github.com/amberframework/amber/issues/698
      it "validates the inclusion of direction" do
        entry = Entry.new
        Entry::VALID_DIRECTIONS.each do |direction|
          entry.direction = direction
          entry.valid?.should be_true
        end

        entry.direction = "360 degree no scope"
        entry.valid?.should be_false
      end
    end
  end
end
