module Retell
  module SDK
    module Unofficial
      class BaseList
        include Enumerable

        attr_reader :items

        def initialize(items_key, raw_response)
          @items = raw_response[items_key]
        end

        def [](index)
          @items[index]
        end

        def each
          if block_given?
            to_a.each do |value|
              yield(value)
            end
            to_a
          else
            to_enum(:each)
          end
        end

        def length
          @items.length
        end

        alias_method :size, :length

        def to_a
          @items
        end

        def empty?
          @items.empty?
        end

        def first
          @items.first
        end

        def last
          @items.last
        end
      end
    end
  end
end
