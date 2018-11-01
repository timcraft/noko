require 'minitest/autorun'
require 'freckle'

class FreckleRecordTest < Minitest::Test
  def id
    123
  end

  attr_accessor :record

  def setup
    self.record = Freckle::Record.new(project_id: id)
  end

  def test_square_brackets_returns_attribute_values
    assert_equal id, record[:project_id]
  end

  def test_method_missing_returns_attribute_values
    assert_equal id, record.project_id
  end

  def test_to_h_returns_attributes_hash
    attributes = {project_id: id}

    assert_equal attributes, record.to_h
  end
end
