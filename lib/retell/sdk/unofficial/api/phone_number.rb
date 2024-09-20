module Retell
  module SDK
    module Unofficial
      module API
        class PhoneNumber
          def initialize(client)
            @client = client
          end

          def create(
            area_code: nil,
            inbound_agent_id: nil,
            inbound_agent: nil,
            nickname: nil,
            outbound_agent_id: nil,
            outbound_agent: nil,
            extra_headers: nil,
            extra_query: nil,
            extra_body: nil,
            timeout: nil
          )
            inbound_agent_id = inbound_agent_id || inbound_agent
            outbound_agent_id = outbound_agent_id || outbound_agent

            inbound_agent_id = inbound_agent_id.is_a?(Retell::SDK::Unofficial::Agent) ? inbound_agent_id.agent_id : inbound_agent_id
            outbound_agent_id = outbound_agent_id.is_a?(Retell::SDK::Unofficial::Agent) ? outbound_agent_id.agent_id : outbound_agent_id

            payload = {
              area_code: area_code,
              inbound_agent_id: inbound_agent_id,
              nickname: nickname,
              outbound_agent_id: outbound_agent_id
            }.compact

            options = @client.make_request_options(
              extra_headers: extra_headers,
              extra_query: extra_query,
              extra_body: extra_body,
              timeout: timeout
            )

            @client.post('/create-phone-number', payload, **options)
          end

          def import(
            phone_number,
            termination_uri:,
            inbound_agent_id: nil,
            inbound_agent: nil,
            nickname: nil,
            outbound_agent_id: nil,
            outbound_agent: nil,
            sip_trunk_auth_password: nil,
            sip_trunk_auth_username: nil,
            extra_headers: nil,
            extra_query: nil,
            extra_body: nil,
            timeout: nil
          )
            inbound_agent_id = inbound_agent_id || inbound_agent
            outbound_agent_id = outbound_agent_id || outbound_agent

            inbound_agent_id = inbound_agent_id.is_a?(Retell::SDK::Unofficial::Agent) ? inbound_agent_id.agent_id : inbound_agent_id
            outbound_agent_id = outbound_agent_id.is_a?(Retell::SDK::Unofficial::Agent) ? outbound_agent_id.agent_id : outbound_agent_id

            payload = {
              phone_number: phone_number,
              termination_uri: termination_uri,
              inbound_agent_id: inbound_agent_id,
              nickname: nickname,
              outbound_agent_id: outbound_agent_id,
              sip_trunk_auth_password: sip_trunk_auth_password,
              sip_trunk_auth_username: sip_trunk_auth_username
            }.compact

            options = @client.make_request_options(
              extra_headers: extra_headers,
              extra_query: extra_query,
              extra_body: extra_body,
              timeout: timeout
            )

            @client.post('/import-phone-number', payload, **options)
          end

          def retrieve(
            phone_number,
            extra_headers: nil,
            extra_query: nil,
            extra_body: nil,
            timeout: nil
          )
            phone_number = phone_number.is_a?(Retell::SDK::Unofficial::PhoneNumber) ? phone_number.phone_number : phone_number

            options = @client.make_request_options(
              extra_headers: extra_headers,
              extra_query: extra_query,
              extra_body: extra_body,
              timeout: timeout
            )

            @client.get("/get-phone-number/#{phone_number}", **options)
          end

          def list(extra_headers: nil, extra_query: nil, extra_body: nil, timeout: nil)
            options = @client.make_request_options(
              extra_headers: extra_headers,
              extra_query: extra_query,
              extra_body: extra_body,
              timeout: timeout
            )

            @client.get('/list-phone-numbers', **options)
          end

          def update(
            phone_number,
            inbound_agent_id: nil,
            inbound_agent: nil,
            nickname: nil,
            outbound_agent_id: nil,
            outbound_agent: nil,
            extra_headers: nil,
            extra_query: nil,
            extra_body: nil,
            timeout: nil
          )
            inbound_agent_id = inbound_agent_id || inbound_agent
            outbound_agent_id = outbound_agent_id || outbound_agent

            phone_number = phone_number.is_a?(Retell::SDK::Unofficial::PhoneNumber) ? phone_number.phone_number : phone_number
            inbound_agent_id = inbound_agent_id.is_a?(Retell::SDK::Unofficial::Agent) ? inbound_agent_id.agent_id : inbound_agent_id
            outbound_agent_id = outbound_agent_id.is_a?(Retell::SDK::Unofficial::Agent) ? outbound_agent_id.agent_id : outbound_agent_id

            payload = {
              inbound_agent_id: inbound_agent_id,
              nickname: nickname,
              outbound_agent_id: outbound_agent_id
            }.compact

            options = @client.make_request_options(
              extra_headers: extra_headers,
              extra_query: extra_query,
              extra_body: extra_body,
              timeout: timeout
            )

            @client.patch("/update-phone-number/#{phone_number}", payload, **options)
          end

          def delete(
            phone_number,
            extra_headers: nil,
            extra_query: nil,
            extra_body: nil,
            timeout: nil
          )
            phone_number = phone_number.is_a?(Retell::SDK::Unofficial::PhoneNumber) ? phone_number.phone_number : phone_number

            options = @client.make_request_options(
              extra_headers: extra_headers,
              extra_query: extra_query,
              extra_body: extra_body,
              timeout: timeout
            )

            @client.delete("/delete-phone-number/#{phone_number}", **options)
          end

          private

          def validate_phone_number(value, param_name)
            raise ArgumentError, "#{param_name} must be a valid phone number in E.164 format" unless value.match?(/^\+[1-9]\d{1,14}$/)
          end
        end
      end
    end
  end
end
