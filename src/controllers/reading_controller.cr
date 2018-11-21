class ReadingController < ApplicationController
  getter reading = Reading.new

  before_action do
    only [:show, :edit, :update, :destroy] { set_reading }
  end

  def index
    readings = Reading.all
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
    reading = Reading.new reading_params.validate!
    if reading.save
      redirect_to action: :index, flash: {"success" => "Created reading successfully."}
    else
      flash["danger"] = "Could not create Reading!"
      render "new.slang"
    end
  end

  def update
    reading.set_attributes reading_params.validate!
    if reading.save
      redirect_to action: :index, flash: {"success" => "Updated reading successfully."}
    else
      flash["danger"] = "Could not update Reading!"
      render "edit.slang"
    end
  end

  def destroy
    reading.destroy
    redirect_to action: :index, flash: {"success" => "Deleted reading successfully."}
  end

  private def reading_params
    params.validation do
      required :value { |f| !f.nil? }
    end
  end

  private def set_reading
    @reading = Reading.find! params[:id]
  end
end
