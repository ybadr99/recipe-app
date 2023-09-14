class RecipesController < ApplicationController
  load_and_authorize_resource
  include RecipesHelper

  def index
    @recipes = Recipe.includes(:recipe_foods).where(user_id: current_user.id)
    notice_message
  end

  def show
    notice_message
    @recipe = Recipe.find(params[:id]).where(user_id: current_user.id)
  end

  def new
    @recipe = Recipe.new
    respond_to do |format|
      format.html { render :new }
      format.js { render :new }
    end
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = 1
    @recipe.public = params[:public] == 'Public'

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipes_path, notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update; end

  def destroy
    @recipe = Recipe.find(params[:id])

    respond_to do |format|
      if can? :destroy, @recipe
        @recipe.destroy
        format.html { redirect_to recipes_path, notice: 'Recipe was successfully deleted.' }
        format.json { head :no_content }
      else
        format.html { redirect_to recipes_path, alert: 'Recipe was not deleted.' }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def public_recipes
    @public_recipes = User.includes(:recipes, :recipe_foods).where(recipes: { public: true })
  end

  def toggle_public
    @recipe = current_user.recipes.find_by(id: params[:id])
    @recipe&.update(public: !@recipe.public)
    redirect_to request.referrer || root_path
  end

  def general_shopping_list
    @recipe_id = params[:recipe_id]
    @inventory_id = params[:inventory_id]
    @recipe = Recipe.find(params[:recipe_id])
    @inventory = Inventory.find(params[:inventory_id])
    recipe_foods = @recipe.recipe_foods.includes(:food)
    inventory_foods = @inventory.inventory_foods.includes(:food)
    @inventories = current_user.inventories
    @missing_foods = []
    @inventories.each do |inventory|
      inventory_foods = inventory.inventory_foods.includes(:food)
      missing_foods = inventory_foods.where.not(food_id: recipe_foods.pluck(:food_id))
      @missing_foods.concat(missing_foods)
    end
    @missing_foods.uniq!

    @total_value_needed = @missing_foods.sum do |missing_food|
      missing_food.quantity * missing_food.food.price
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
