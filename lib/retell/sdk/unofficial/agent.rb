module Retell
  module SDK
    module Unofficial
      class Agent < Base
        @attributes = [
          :agent_id, :llm_websocket_url, :voice_id, :agent_name, :ambient_sound, :ambient_sound_volume, :backchannel_frequency, :backchannel_words, :boosted_keywords, :enable_backchannel,:enable_voicemail_detection, :end_call_after_silence_ms, :fallback_voice_ids, :interruption_sensitivity, :language, :last_modification_timestamp, :max_call_duration_ms, :normalize_for_speech, :opt_out_sensitive_data_storage, :post_call_analysis_data, :pronunciation_dictionary, :reminder_max_count, :reminder_trigger_ms, :responsiveness, :voice_model, :voice_speed, :voice_temperature, :voicemail_detection_timeout_ms, :voicemail_message, :volume, :webhook_url
        ]

        @writeable_attributes = [
          :llm_websocket_url, :voice_id, :agent_name, :ambient_sound, :ambient_sound_volume, :backchannel_frequency, :backchannel_words, :boosted_keywords, :enable_backchannel, :enable_voicemail_detection, :end_call_after_silence_ms, :fallback_voice_ids, :interruption_sensitivity, :language, :max_call_duration_ms, :normalize_for_speech, :opt_out_sensitive_data_storage, :post_call_analysis_data, :pronounciation_dictionary, :reminder_max_count, :reminder_trigger_ms, :responsiveness, :voice_model, :voice_speed, :voice_temperature, :voicemail_detection_timeout_ms, :voicemail_message, :volume, :webhook_url
        ]

        attr_reader *@attributes

        @writeable_attributes.each do |attr|
          define_method("#{attr}=") do |value|
            self[attr] = value
          end
        end

        def id
          agent_id
        end

        def name
          agent_name
        end

        def name=(value)
          self[:agent_name] = value
        end

        def voice
          voice_id
        end

        def voice=(value)
          self[:voice_id] = value
        end

        def fallback_voices
          fallback_voice_ids
        end

        def fallback_voices=(value)
          self[:fallback_voice_ids] = value
        end

        def retrieve
          @client.agent.retrieve(self)
        end

        def update(**params)
          update_params = @changed_attributes.merge(params)

          if update_params.any?
            updated_agent = @client.agent.update(self, **update_params)
            self.class.attributes.each do |attr|
              instance_variable_set("@#{attr}", updated_agent.send(attr))
            end
            @changed_attributes.clear
          end

          self
        end

        def delete
          @client.agent.delete(self)
        end
      end
    end
  end
end
