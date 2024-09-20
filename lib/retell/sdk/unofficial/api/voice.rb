module Retell
  module SDK
    module Unofficial
      module API
        class Voice
          def initialize(client)
            @client = client
          end

          def retrieve(
            voice_or_id,
            extra_headers: nil,
            extra_query: nil,
            extra_body: nil,
            timeout: nil
          )
            voice_id = voice_or_id.is_a?(Retell::SDK::Unofficial::Voice) ? voice_or_id.voice_id : voice_or_id

            raise ArgumentError, "Expected a non-empty value for `voice_id` but received #{voice_id.inspect}" if voice_id.to_s.empty?

            options = @client.make_request_options(
              extra_headers: extra_headers,
              extra_query: extra_query,
              extra_body: extra_body,
              timeout: timeout
            )

            @client.get("/get-voice/#{voice_id}", **options)
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

            @client.get('/list-voices', **options)
          end
        end
      end
    end
  end
end
