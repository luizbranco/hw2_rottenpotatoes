class FilterCache

  def initialize(cache = {})
    @cache = cache
  end

  def save(values)
    values.each do |key, value|
      @cache[key] = value
    end
  end

  def load(key)
    @cache[key]
  end

end
