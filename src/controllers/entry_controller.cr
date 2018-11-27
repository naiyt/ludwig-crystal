class EntryController < ApplicationController
  getter entry = Entry.new

  before_action do
    only [:show, :edit, :update, :destroy] { set_entry }
  end

  def index
    entries = Entry.all
    render "index.slang"
  end

  def show
    render "show.slang"
  end

  def new
    render "new.slang"
  end

  def edit
    render "edit.slang"
  end

  def create
    entry = Entry.new entry_params.validate!
    if entry.save
      redirect_to action: :index, flash: {"success" => "Created entry successfully."}
    else
      flash["danger"] = "Could not create Entry!"
      render "new.slang"
    end
  end

  def update
    entry.set_attributes entry_params.validate!
    if entry.save
      redirect_to action: :index, flash: {"success" => "Updated entry successfully."}
    else
      flash["danger"] = "Could not update Entry!"
      render "edit.slang"
    end
  end

  def destroy
    entry.destroy
    redirect_to action: :index, flash: {"success" => "Deleted entry successfully."}
  end

  private def entry_params
    params.validation do
      required :device { |f| !f.nil? }
      required :date_string { |f| !f.nil? }
      required :sgv { |f| !f.nil? }
      required :delta { |f| !f.nil? }
      required :direction { |f| !f.nil? }
      required :filtered { |f| !f.nil? }
      required :unfiltered { |f| !f.nil? }
      required :rssi { |f| !f.nil? }
      required :noise { |f| !f.nil? }
      required :sys_time { |f| !f.nil? }
    end
  end

  private def set_entry
    @entry = Entry.find! params[:id]
  end
end
