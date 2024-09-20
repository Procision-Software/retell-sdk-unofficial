module Retell
  module SDK
    module Unofficial
      class PhoneNumber < Base
        @attributes = [
          :phone_number, :phone_number_pretty, :inbound_agent_id, :outbound_agent_id,
          :area_code, :nickname, :last_modification_timestamp
        ]

        @writeable_attributes = [
          :inbound_agent_id, :outbound_agent_id, :nickname
        ]

        attr_reader *@attributes

        @writeable_attributes.each do |attr|
          define_method("#{attr}=") do |value|
            self[attr] = value
          end
        end

        def inbound_agent
          inbound_agent_id
        end

        def inbound_agent=(value)
          self[:inbound_agent_id] = value
        end

        def outbound_agent
          outbound_agent_id
        end

        def outbound_agent=(value)
          self[:outbound_agent_id] = value
        end

        def retrieve
          @client.phone_number.retrieve(self)
        end

        def update(**params)
          update_params = @changed_attributes.merge(params)

          if update_params.any?
            updated_phone_number = @client.phone_number.update(self, **update_params)
            self.class.attributes.each do |attr|
              instance_variable_set("@#{attr}", updated_phone_number.send(attr))
            end
            @changed_attributes.clear
          end

          self
        end

        def delete
          @client.phone_number.delete(self)
        end
      end
    end
  end
end
