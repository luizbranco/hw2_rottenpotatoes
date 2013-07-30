module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end

  def is_checked?(name, filter)
    return true if filter.empty?
    filter.include? name
  end

  def save_filters(order, params)
    {order_by: order, ratings: params[:ratings]}
  end

end
