class CocktailsController < ApplicationController
  def index
    if params[:query].present?
      @cocktail = Cocktail.where("name ILIKE ?", "%#{params[:query]}")
    else
      @cocktails = Cocktail.all
    end
  end

  def show
    @cocktail = Cocktail.find(params[:id])
    @doses = @cocktail.doses
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def edit
    @cocktail = Cocktail.find(params[:id])
  end

  def update
    @cocktail = Cocktail.find(params[:id])
    @cocktail.update(cocktail_params)
    if @cocktail.save
      redirect_to cocktail_path
    else
      render :edit
    end
  end

  def destroy
    @cocktail = Cocktail.find(params[:id])
    @cocktail.destroy
    redirect_to root_path
  end

private
  def cocktail_params
    params.require(:cocktail).permit(:name, :photo)
  end
end
