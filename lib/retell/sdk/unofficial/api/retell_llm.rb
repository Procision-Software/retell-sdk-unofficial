module Retell
  module SDK
    module Unofficial
      module API
        class RetellLLM
          def initialize(client)
            @client = client
          end

          def create(
            begin_message: nil,
            general_prompt: nil,
            general_tools: nil,
            inbound_dynamic_variables_webhook_url: nil,
            model: nil,
            model_temperature: nil,
            starting_state: nil,
            states: nil,
            extra_headers: nil,
            extra_query: nil,
            extra_body: nil,
            timeout: nil
          )
            validate_model(model) if model
            validate_model_temperature(model_temperature) if model_temperature
            validate_general_tools(general_tools) if general_tools
            validate_states(states) if states

            payload = {
              begin_message: begin_message,
              general_prompt: general_prompt,
              general_tools: general_tools,
              inbound_dynamic_variables_webhook_url: inbound_dynamic_variables_webhook_url,
              model: model,
              model_temperature: model_temperature,
              starting_state: starting_state,
              states: states
            }.compact

            options = @client.make_request_options(
              extra_headers: extra_headers,
              extra_query: extra_query,
              extra_body: extra_body,
              timeout: timeout
            )

            @client.post('/create-retell-llm', payload, **options)
          end

          def retrieve(
            llm_or_id,
            extra_headers: nil,
            extra_query: nil,
            extra_body: nil,
            timeout: nil
          )
            llm_id = llm_or_id.is_a?(Retell::SDK::Unofficial::RetellLLM) ? llm_or_id.llm_id : llm_or_id
            validate_non_empty_string(llm_id, 'llm_id')

            options = @client.make_request_options(
              extra_headers: extra_headers,
              extra_query: extra_query,
              extra_body: extra_body,
              timeout: timeout
            )

            @client.get("/get-retell-llm/#{llm_id}", **options)
          end

          def update(
            llm_or_id,
            begin_message: nil,
            general_prompt: nil,
            general_tools: nil,
            inbound_dynamic_variables_webhook_url: nil,
            model: nil,
            model_temperature: nil,
            starting_state: nil,
            states: nil,
            extra_headers: nil,
            extra_query: nil,
            extra_body: nil,
            timeout: nil
          )
            llm_id = llm_or_id.is_a?(Retell::SDK::Unofficial::RetellLLM) ? llm_or_id.llm_id : llm_or_id
            validate_non_empty_string(llm_id, 'llm_id')

            validate_model(model) if model
            validate_model_temperature(model_temperature) if model_temperature
            validate_general_tools(general_tools) if general_tools
            validate_states(states) if states

            payload = {
              begin_message: begin_message,
              general_prompt: general_prompt,
              general_tools: general_tools,
              inbound_dynamic_variables_webhook_url: inbound_dynamic_variables_webhook_url,
              model: model,
              model_temperature: model_temperature,
              starting_state: starting_state,
              states: states
            }.compact

            options = @client.make_request_options(
              extra_headers: extra_headers,
              extra_query: extra_query,
              extra_body: extra_body,
              timeout: timeout
            )

            @client.patch("/update-retell-llm/#{llm_id}", payload, **options)
          end

          def list(
            extra_headers: nil,
            extra_query: nil,
            extra_body: nil,
            timeout: nil
          )
            options = @client.make_request_options(
              extra_headers: extra_headers,
              extra_query: extra_query,
              extra_body: extra_body,
              timeout: timeout
            )

            @client.get('/list-retell-llms', **options)
          end

          def delete(
            llm_or_id,
            extra_headers: nil,
            extra_query: nil,
            extra_body: nil,
            timeout: nil
          )
            llm_id = llm_or_id.is_a?(Retell::SDK::Unofficial::RetellLLM) ? llm_or_id.llm_id : llm_or_id
            validate_non_empty_string(llm_id, 'llm_id')

            options = @client.make_request_options(
              extra_headers: extra_headers,
              extra_query: extra_query,
              extra_body: extra_body,
              timeout: timeout
            )

            @client.delete("/delete-retell-llm/#{llm_id}", **options)
            nil
          end

          private

          def validate_model(model)
            valid_models = ['gpt-4o', 'gpt-4o-mini', 'claude-3.5-sonnet', 'claude-3-haiku']
            unless valid_models.include?(model)
              raise ArgumentError, "Invalid model: #{model}. Valid models are: #{valid_models.join(', ')}"
            end
          end

          def validate_model_temperature(model_temperature)
            unless model_temperature >= 0 && model_temperature <= 1
              raise ArgumentError, "Invalid model temperature: #{model_temperature}. Model temperature must be a between 0 and 1"
            end
          end

          def validate_general_tools(tools)
            tools.each { |tool| validate_general_tool(tool) }
          end

          def validate_states(states)
            states.each do |state|
              unless state.is_a?(Hash) && state.key?(:name)
                raise ArgumentError, "Invalid state: each state must be a hash with a 'name' key"
              end
              validate_state(state)
            end
          end

          def validate_general_tool(tool)
            case tool[:type]
            when 'end_call', 'press_digit'
              validate_tool_keys(tool, required: [:name, :type], optional: [:description])
            when 'transfer_call'
              validate_tool_keys(tool, required: [:name, :number, :type], optional: [:description])
            when 'check_availability_cal', 'book_appointment_cal'
              validate_tool_keys(tool, required: [:cal_api_key, :event_type_id, :name, :type], optional: [:description, :timezone])
            when 'custom'
              validate_custom_tool(tool)
            else
              raise ArgumentError, "Unknown general tool type: #{tool[:type]}"
            end
          end

          def validate_custom_tool(tool)
            validate_tool_keys(tool,
              required: [:name, :type, :description, :url, :speak_after_execution, :speak_during_execution],
              optional: [:execution_message_description, :timeout_ms, :parameters]
            )
            validate_custom_tool_parameters(tool[:parameters]) if tool[:parameters]
            validate_timeout_ms(tool[:timeout_ms]) if tool[:timeout_ms]
          end

          def validate_timeout_ms(timeout_ms)
            unless timeout_ms.is_a?(Integer) && timeout_ms >= 1000 && timeout_ms <= 600000
              raise ArgumentError, "timeout_ms must be an integer between 1000 and 600000"
            end
          end

          def validate_custom_tool_parameters(parameters)
            validate_tool_keys(parameters, required: [:type, :properties], optional: [:required])
          end

          def validate_state(state)
            validate_tool_keys(state, required: [:name], optional: [:edges, :state_prompt, :tools])
            validate_general_tools(state[:tools]) if state[:tools]
            validate_state_edges(state[:edges]) if state[:edges]
          end

          def validate_state_edges(edges)
            edges.each { |edge| validate_state_edge(edge) }
          end

          def validate_state_edge(edge)
            validate_tool_keys(edge,
              required: [:description, :destination_state_name],
              optional: [:parameters]
            )
            validate_state_edge_parameters(edge[:parameters]) if edge[:parameters]
          end

          def validate_state_edge_parameters(parameters)
            validate_tool_keys(parameters, required: [:type, :properties], optional: [:required])
          end

          def validate_tool_keys(hash, required: [], optional: [])
            missing_keys = required - hash.keys
            if missing_keys.any?
              raise ArgumentError, "Missing required keys: #{missing_keys.join(', ')}"
            end

            unexpected_keys = hash.keys - (required + optional)
            if unexpected_keys.any?
              raise ArgumentError, "Unexpected keys found: #{unexpected_keys.join(', ')}"
            end
          end

          def validate_non_empty_string(value, name)
            raise ArgumentError, "#{name} cannot be empty" if value.empty?
          end
        end
      end
    end
  end
end
