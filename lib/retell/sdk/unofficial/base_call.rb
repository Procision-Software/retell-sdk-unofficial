require_relative 'base'

module Retell
  module SDK
    module Unofficial
      class BaseCall < Base
        @attributes = [
          :call_id, :agent_id, :call_status, :call_type,
          :start_timestamp, :end_timestamp, :transcript, :recording_url,
          :public_log_url, :call_analysis, :e2e_latency, :llm_latency,
          :llm_websocket_network_rtt_latency, :transcript_object,
          :transcript_with_tool_calls, :disconnection_reason, :metadata,
          :retell_llm_dynamic_variables, :opt_out_sensitive_data_storage
        ]

        attr_reader *@attributes

        def id
          call_id
        end

        def agent
          agent_id
        end

        def status
          call_status
        end

        def type
          call_type
        end

        def analysis
          call_analysis
        end
      end
    end
  end
end
