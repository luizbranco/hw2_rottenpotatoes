require_relative '../../lib/filter_by.rb'

class Dummy; end;

describe FilterBy do

  describe '#method_missing' do

    it "filter if class has column name" do
      Dummy.should_receive(:column_names).and_return(['rating'])
      Dummy.stub(:all)
      filter = FilterBy.new(Dummy)
      filter.rating
    end

  end

  describe '#by_attribute' do

    before do
      Dummy.stub(:column_names).and_return(['rating'])
    end

    let(:filter) { FilterBy.new(Dummy) }

    it "filters by an attribute if an values are passed" do
      Dummy.should_receive(:where).with(rating: [:PG])
      filter.rating({PG: '1'})
    end

    it "returns all if no value is passed" do
      Dummy.should_receive(:all)
      filter.rating
    end

  end

end
