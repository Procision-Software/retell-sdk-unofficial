module Retell
  module SDK
    module Unofficial
      module API
        class Concurrency
          def initialize(client)
            @client = client
          end

          def retrieve(
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
            @client.request(:get, '/get-concurrency', {}, **options)
          end
        end
      end
    end
  end
end
