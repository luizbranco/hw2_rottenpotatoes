require_relative '../../lib/filter_by.rb'
require_relative '../../lib/filter_cache.rb'

class MoviesController < ApplicationController
  before_filter :restful_redirect, only: :index

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

  def restful_redirect
    s, p = session, params
    if s[:order_by] && !p[:order_by]
      redirect_to movies_path(order_by: s[:order_by], ratings: (p[:ratings] || s[:ratings]))
    elsif s[:ratings] && !p[:ratings]
      redirect_to movies_path(order_by: (p[:order_by] || s[:order_by]), ratings: s[:ratings])
    end
    return
  end

end
