module Retell
  module SDK
    module Unofficial
      module API
        class Call
          def initialize(client)
            @client = client
          end

          def create_web_call(
            agent_id:,
            metadata: nil,
            retell_llm_dynamic_variables: nil,
            extra_headers: nil,
            extra_query: nil,
            extra_body: nil,
            timeout: nil
          )
            agent_id = agent_id.is_a?(Retell::SDK::Unofficial::Agent) ? agent_id.agent_id : agent_id

            validate_non_empty_string(agent_id, 'agent_id')

            payload = {
              agent_id: agent_id,
              metadata: metadata,
              retell_llm_dynamic_variables: retell_llm_dynamic_variables
            }.compact

            options = @client.make_request_options(
              extra_headers: extra_headers,
              extra_query: extra_query,
              extra_body: extra_body,
              timeout: timeout
            )

            @client.post('/v2/create-web-call', payload, **options)
          end

          def create_phone_call(
            from_number:,
            to_number:,
            override_agent_id: nil,
            metadata: nil,
            retell_llm_dynamic_variables: nil,
            extra_headers: nil,
            extra_query: nil,
            extra_body: nil,
            timeout: nil
          )
            override_agent_id = override_agent_id.is_a?(Retell::SDK::Unofficial::Agent) ? override_agent_id.agent_id : override_agent_id

            validate_phone_number(from_number, 'from_number')
            validate_phone_number(to_number, 'to_number')
            validate_non_empty_string(override_agent_id, 'override_agent_id') if override_agent_id

            payload = {
              from_number: from_number,
              to_number: to_number,
              override_agent_id: override_agent_id,
              metadata: metadata,
              retell_llm_dynamic_variables: retell_llm_dynamic_variables
            }.compact

            options = @client.make_request_options(
              extra_headers: extra_headers,
              extra_query: extra_query,
              extra_body: extra_body,
              timeout: timeout
            )

            @client.post('/v2/create-phone-call', payload, **options)
          end

          def register(
            agent_id:,
            direction: nil,
            from_number: nil,
            to_number: nil,
            metadata: nil,
            retell_llm_dynamic_variables: nil,
            extra_headers: nil,
            extra_query: nil,
            extra_body: nil,
            timeout: nil
          )
            agent_id = agent_id.is_a?(Retell::SDK::Unofficial::Agent) ? agent_id.agent_id : agent_id

            validate_non_empty_string(agent_id, 'agent_id')
            validate_direction(direction) if direction
            validate_phone_number(from_number, 'from_number') if from_number
            validate_phone_number(to_number, 'to_number') if to_number


            payload = {
              agent_id: agent_id,
              direction: direction,
              from_number: from_number,
              to_number: to_number,
              metadata: metadata,
              retell_llm_dynamic_variables: retell_llm_dynamic_variables
            }.compact

            options = @client.make_request_options(
              extra_headers: extra_headers,
              extra_query: extra_query,
              extra_body: extra_body,
              timeout: timeout
            )

            @client.post('/v2/register-phone-call', payload, **options)
          end

          def retrieve(
            call_or_id,
            extra_headers: nil,
            extra_query: nil,
            extra_body: nil,
            timeout: nil
          )
            call_id = (call_or_id.is_a?(Retell::SDK::Unofficial::PhoneCall) || call_or_id.is_a?(Retell::SDK::Unofficial::WebCall)) ? call_or_id.call_id : call_or_id

            validate_non_empty_string(call_id, 'call_id')

            options = @client.make_request_options(
              extra_headers: extra_headers,
              extra_query: extra_query,
              extra_body: extra_body,
              timeout: timeout
            )

            @client.get("/v2/get-call/#{call_id}", **options)
          end

          def list(
            filter_criteria: nil,
            limit: nil,
            pagination_key: nil,
            sort_order: nil,
            extra_headers: nil,
            extra_query: nil,
            extra_body: nil,
            timeout: nil
          )
            validate_positive_integer(limit, 'limit') if limit
            validate_sort_order(sort_order) if sort_order
            validate_filter_criteria(filter_criteria) if filter_criteria

            payload = {
              filter_criteria: filter_criteria,
              limit: limit,
              pagination_key: pagination_key,
              sort_order: sort_order
            }.compact

            options = @client.make_request_options(
              extra_headers: extra_headers,
              extra_query: extra_query,
              extra_body: extra_body,
              timeout: timeout
            )

            @client.post('/v2/list-calls', payload, **options)
          end

          private

          def validate_non_empty_string(value, param_name)
            raise ArgumentError, "#{param_name} must be a non-empty string" if value.to_s.empty?
          end

          def validate_phone_number(value, param_name)
            raise ArgumentError, "#{param_name} must be a valid phone number in E.164 format" unless value.match?(/^\+[1-9]\d{1,14}$/)
          end

          def validate_direction(value)
            raise ArgumentError, "direction must be either 'inbound' or 'outbound'" unless ['inbound', 'outbound'].include?(value)
          end

          def validate_positive_integer(value, param_name)
            raise ArgumentError, "#{param_name} must be a positive integer" unless value.is_a?(Integer) && value > 0
          end

          def validate_sort_order(value)
            raise ArgumentError, "sort_order must be either 'ascending' or 'descending'" unless ['ascending', 'descending'].include?(value)
          end

          def validate_filter_criteria(criteria)
            criteria.each do |key, value|
              case key
              when :after_end_timestamp, :after_start_timestamp, :before_end_timestamp, :before_start_timestamp
                validate_timestamp(value, key.to_s)
              when :agent_id
                if value.is_a?(Array)
                  raise ArgumentError, "agent_id array cannot be empty" if value.empty?
                  value.each { |id| validate_non_empty_string(id, 'agent_id') }
                else
                  validate_non_empty_string(value, 'agent_id')
                end
              else
                raise ArgumentError, "Invalid filter criteria key: #{key}"
              end
            end
          end

          def validate_timestamp(value, param_name)
            raise ArgumentError, "#{param_name} must be a valid timestamp" unless value.is_a?(Integer) || value.is_a?(Time)
          end
        end
      end
    end
  end
end
