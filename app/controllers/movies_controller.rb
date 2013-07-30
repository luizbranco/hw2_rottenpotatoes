require_relative '../../lib/filter_by.rb'
require_relative '../../lib/filter_cache.rb'

class MoviesController < ApplicationController

  def show
    id = params[:id]
    @movie = Movie.find(id)
  end

  def index
    @sort_column = Movie.column_names.include?(cache.load(:order_by)) ? cache.load(:order_by) : "id"
    @filter = FilterBy.new(Movie)
    @movies = @filter.rating(cache.load(:ratings)).order(@sort_column)
    @all_ratings = Movie.ratings
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private

  def cache
    cache = FilterCache.new(session)
    cache.save(params)
    cache
  end

end
