require 'spec_helper'

RSpec.describe Noko::Record do
  let(:id) { 123 }
  let(:record) { Noko::Record.new(project_id: id) }

  describe '#[]' do
    it 'returns attribute values' do
      expect(record[:project_id]).to eq(id)
    end
  end

  describe '#method_missing' do
    it 'returns attribute values' do
      expect(record.project_id).to eq(id)
    end
  end

  describe '#to_h' do
    it 'returns an attributes hash' do
      attributes = {project_id: id}

      expect(record.to_h).to eq(attributes)
    end
  end
end
