class RecipesController < ApplicationController
  load_and_authorize_resource
  include RecipesHelper

  def index
    @recipes = Recipe.includes(:recipe_foods).where(user_id: current_user.id)
    notice_message
  end

  def show
    notice_message
    @recipe = Recipe.find(params[:id])
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
    @recipe.user = current_user
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
    @public_recipes = User.includes(:recipes,
                                    :recipe_foods).where(recipes: { public: true }).order('recipes.created_at DESC')
  end

  def toggle_public
    @recipe = Recipe.find(params[:id])
    @recipe.toggle!(:public)
    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipes_path, notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { redirect_to recipes_path, alert: 'Recipe was not updated.' }
        format.json { render json: @recipe.errors, status: unprocessable_entity }
      end
    end
  end

  def general_shopping_list
    @shopping_list = Food.includes(:recipe_foods).where(recipe_foods: { recipe_id: nil })
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
