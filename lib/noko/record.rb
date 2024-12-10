# frozen_string_literal: true

class Noko::Record
  def initialize(attributes = {})
    @attributes = attributes
  end

  def [](name)
    @attributes[name]
  end

  def []=(name, value)
    @attributes[name] = value
  end

  def inspect
    '#<' + self.class.name + ' ' + @attributes.map { "#{_1}=#{_2.inspect}" }.join(', ') + '>'
  end

  def method_missing(name, *args, &block)
    if @attributes.key?(name) && args.empty? && block.nil?
      return @attributes[name]
    else
      super name, *args, &block
    end
  end

  def respond_to_missing?(name, include_private = false)
    @attributes.key?(name)
  end

  def to_h
    @attributes
  end
end
