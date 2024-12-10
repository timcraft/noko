require 'spec_helper'

RSpec.describe Noko::Params do
  describe '.encode' do
    it 'returns a string' do
      expect(subject.encode({name: 'Example project'})).to eq('name=Example%20project')
      expect(subject.encode({project_ids: [123, 456, 789]})).to eq('project_ids=123,456,789')
    end
  end
end
