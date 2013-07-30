require_relative '../../lib/filter_cache'

describe FilterCache do

  let(:cache) { FilterCache.new }

  it "saves to cache" do
    cache.save({ratings: 'PG'})
    cache.load(:ratings).should eq('PG')
  end

  it "retains previous cached info" do
    cache = FilterCache.new({order_by: 'title'})
    cache.save({ratings: 'PG'})
    cache.load(:ratings).should eq('PG')
    cache.load(:order_by).should eq('title')
  end

end
