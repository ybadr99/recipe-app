class FoodsController < ApplicationController
  load_and_authorize_resource
  include FoodsHelper

  def index
    notice_message
    @foods = Food.all.where(user_id: current_user.id)
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
    @food.user = current_user
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
    respond_to do |format|
      if can? :destroy, @food
        @food.destroy
        format.html { redirect_to foods_path, notice: 'Food item was successfully deleted.' }
        format.json { head :no_content }
      else
        format.html { redirect_to foods_path, alert: 'Food item was not deleted.' }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
