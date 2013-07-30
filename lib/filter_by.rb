class FilterBy

  attr_reader :attribute

  def initialize(klass)
    @klass = klass
  end

  def by_attribute(attribute, hash)
    @attribute, @hash = attribute, hash
    if values.any?
      @klass.where(attribute => values)
    else
      @klass.all
    end
  end

  def values
    @hash = @hash || {}
    @hash.select {|k,v| v == '1'}.keys
  end

  def method_missing(method_id, *args, &block)
    if @klass.column_names.include? method_id.to_s
      by_attribute(method_id, args.first)
    else
      super
    end
  end

end
