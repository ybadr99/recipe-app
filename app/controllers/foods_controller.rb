class FoodsController < ApplicationController
  include FoodsHelper
  
  def index
    notice_message
    @foods = Food.all
  end

  def new
    @food = Food.new
    respond_to do |format|
      format.html { render :new }
      format.js { render :new }
    end
  end

  def create
    @food = Food.new(food_params)
    @food.user_id = 1
    respond_to do |format|
      if @food.save
        format.html { redirect_to foods_path, notice: 'Food item was successfully created.' }
        format.json { render :show, status: :created, location: @food }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @food.errors, status: :unprocessable_entity }
        format.turbo_stream { render :new_update, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @food = Food.find(params[:id])
    respond_to do |format|
      format.html { render :edit }
      format.js { render :edit }
    end
  end

  def update
    @food = Food.find(params[:id])
    respond_to do |format|
      if @food.update(food_params)
        format.html { redirect_to foods_path, notice: 'Food item was successfully updated.' }
        format.json { render :show, status: :ok, location: @food }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @food.errors, status: :unprocessable_entity }
        format.turbo_stream { render :edit_update, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to foods_path, notice: 'Food item was successfully deleted.'
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
