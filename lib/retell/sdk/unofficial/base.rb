module Retell
  module SDK
    module Unofficial
      class Base
        class << self
          attr_reader :attributes
        end

        attr_accessor :client

        def self.inherited(subclass)
          subclass.instance_variable_set(:@attributes, [])
        end

        def self.each_attribute
          @attributes.each { |attr| yield attr }
        end

        attr_reader :changed_attributes

        def self.writeable_attributes
          @writeable_attributes ||= []
        end

        def initialize(client, raw_response)
          @client = client
          @changed_attributes = {}
          self.class.attributes.each do |attr|
            instance_variable_set("@#{attr}", raw_response[attr])
          end
        end

        def [](key)
          send(key) if self.class.attributes.include?(key.to_sym)
        end

        def []=(key, value)
          if self.class.writeable_attributes.include?(key.to_sym)
            instance_variable_set("@#{key}", value)
            @changed_attributes[key.to_sym] = value
          else
            raise KeyError, "key not found or not writable: #{key}"
          end
        end

        def to_h
          self.class.attributes.each_with_object({}) do |attr, hash|
            hash[attr] = send(attr)
          end
        end

        def keys
          self.class.attributes
        end

        def values
          self.class.attributes.map { |attr| send(attr) }
        end

        def each
          if block_given?
            to_h.each do |key, value|
              yield(key, value)
            end
            to_h
          else
            to_enum(:each)
          end
        end

        def fetch(key, default = nil)
          if self.class.attributes.include?(key.to_sym)
            send(key)
          else
            block_given? ? yield(key) : (default || raise(KeyError, "key not found: #{key}"))
          end
        end
      end
    end
  end
end
