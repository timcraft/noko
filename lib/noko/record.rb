module Noko
  class Record
    def initialize(attributes = {})
      @attributes = attributes
    end

    def [](name)
      @attributes[name]
    end

    def []=(name, value)
      @attributes[name] = value
    end

    def method_missing(name, *args, &block)
      if @attributes.has_key?(name) && args.empty? && block.nil?
        return @attributes[name]
      else
        super name, *args, &block
      end
    end

    def respond_to_missing?(name, include_private = false)
      @attributes.has_key?(name)
    end

    def to_h
      @attributes
    end
  end
end
