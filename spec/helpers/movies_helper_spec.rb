require_relative '../../app/helpers/movies_helper'

class Dummy
  include MoviesHelper
end

describe MoviesHelper do

  let(:helper) { Dummy.new }

  describe '#is_checked?' do

    it "is true when filter list is empty" do
      filter = []
      helper.is_checked?('PG', filter).should be_true
    end

    it "is true when name exists in filter list" do
      filter = ['PG']
      helper.is_checked?('PG', filter).should be_true
    end

    it "is false when name doesn't exist in filter list" do
      filter = ['G']
      helper.is_checked?('PG', filter).should be_false
    end

  end

  describe '#save_filters' do

    it "combine previous filters with sort by" do
      params = {ratings: ['PG']}
      helper.save_filters('title', params).should eq({ratings: ['PG'], order_by: 'title'})
    end

  end

end
