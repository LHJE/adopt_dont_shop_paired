class FavoritesController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_action :favorites

  def index
    @favorite_pets = session[:favorites]
    @pets = Pet.all
  end

  def update
    pet = Pet.find(params[:id])
    if favorites.favorite_pets.include?(pet.id.to_s)
      session[:favorites].delete(params[:id])
      flash[:notice] = "#{pet.name} has been removed from your Favorites!"
      redirect_to "/pets/#{pet.id}"
    else
      favorites.add_pet(pet)
      session[:favorites] = favorites.favorite_pets
      flash[:notice] = "#{pet.name} has been added to your Favorites!"
      redirect_to "/pets/#{pet.id}"
    end
  end

  def remove
    pet = Pet.find(params[:id])
    session[:favorites].delete(params[:id])
    flash[:notice] = "#{pet.name} has been removed from your Favorites!"
    redirect_to "/favorites"
  end

  def remove_all
    favorites.favorite_pets.clear
    redirect_to "/favorites"
  end

end
