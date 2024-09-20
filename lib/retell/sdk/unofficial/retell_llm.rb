module Retell
  module SDK
    module Unofficial
      class RetellLLM < Base
        @attributes = [
          :last_modification_timestamp, :llm_id, :llm_websocket_url, :begin_message,
          :general_prompt, :general_tools, :inbound_dynamic_variables_webhook_url,
          :model, :model_temperature, :starting_state, :states
        ]

        @writeable_attributes = [
          :begin_message,:general_prompt, :general_tools, :inbound_dynamic_variables_webhook_url, :model, :model_temperature, :states, :starting_state
        ]

        attr_reader *@attributes

        def id
          llm_id
        end

        def websocket_url
          llm_websocket_url
        end

        def url
          llm_websocket_url
        end

        @writeable_attributes.each do |attr|
          define_method("#{attr}=") do |value|
            self[attr] = value
          end
        end

        def retrieve
          @client.retell_llm.retrieve(self)
        end

        def update(**params)
          update_params = @changed_attributes.merge(params)

          if update_params.any?
            updated_retell_llm = @client.retell_llm.update(self, **update_params)
            self.class.attributes.each do |attr|
              instance_variable_set("@#{attr}", updated_retell_llm.send(attr))
            end
            @changed_attributes.clear
          end

          self
        end

        def delete
          @client.retell_llm.delete(self)
        end
      end
    end
  end
end
