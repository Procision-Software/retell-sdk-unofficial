module Retell
  module SDK
    module Unofficial
      module API
        class Agent
          def initialize(client)
            @client = client
          end

          def create(
            response_engine:,
            voice_id:,
            agent_name: nil,
            ambient_sound: nil,
            ambient_sound_volume: nil,
            backchannel_frequency: nil,
            backchannel_words: nil,
            boosted_keywords: nil,
            enable_backchannel: nil,
            enable_voicemail_detection: nil,
            end_call_after_silence_ms: nil,
            fallback_voice_ids: nil,
            fallback_voices: nil,
            interruption_sensitivity: nil,
            language: nil,
            max_call_duration_ms: nil,
            name: nil,
            normalize_for_speech: nil,
            opt_out_sensitive_data_storage: nil,
            post_call_analysis_data: nil,
            pronunciation_dictionary: nil,
            reminder_max_count: nil,
            reminder_trigger_ms: nil,
            responsiveness: nil,
            voice: nil,
            voice_model: nil,
            voice_speed: nil,
            voice_temperature: nil,
            voicemail_detection_timeout_ms: nil,
            voicemail_message: nil,
            volume: nil,
            webhook_url: nil,
            extra_headers: nil,
            extra_query: nil,
            extra_body: nil,
            timeout: nil
          )
            agent_name = agent_name || name
            voice_id = voice_id || voice
            fallback_voice_ids = fallback_voice_ids || fallback_voices

            voice_id = voice_id.is_a?(Retell::SDK::Unofficial::Voice) ? voice_id.voice_id : voice_id
            fallback_voice_ids = fallback_voice_ids.is_a?(Array) ? verify_fallback_voice_ids(fallback_voice_ids) : fallback_voice_ids

            validate_voice_model(voice_model)
            validate_ambient_sound(ambient_sound)
            validate_language(language)
            validate_numeric_range(ambient_sound_volume, 'ambient_sound_volume', 0, 1)
            validate_numeric_range(backchannel_frequency, 'backchannel_frequency', 0, 1)
            validate_numeric_range(interruption_sensitivity, 'interruption_sensitivity', 0, 1)
            validate_numeric_range(responsiveness, 'responsiveness', 0, 1)
            validate_numeric_range(voice_speed, 'voice_speed', 0.5, 2)
            validate_numeric_range(voice_temperature, 'voice_temperature', 0, 2)
            validate_numeric_range(volume, 'volume', 0, 2)

            payload = {
              response_engine: response_engine,
              voice_id: voice_id,
              agent_name: agent_name,
              ambient_sound: ambient_sound,
              ambient_sound_volume: ambient_sound_volume&.to_f,
              backchannel_frequency: backchannel_frequency&.to_f,
              backchannel_words: backchannel_words,
              boosted_keywords: boosted_keywords,
              enable_backchannel: enable_backchannel,
              enable_voicemail_detection: enable_voicemail_detection,
              end_call_after_silence_ms: end_call_after_silence_ms,
              fallback_voice_ids: fallback_voice_ids,
              interruption_sensitivity: interruption_sensitivity&.to_f,
              language: language,
              max_call_duration_ms: max_call_duration_ms,
              normalize_for_speech: normalize_for_speech,
              opt_out_sensitive_data_storage: opt_out_sensitive_data_storage,
              post_call_analysis_data: post_call_analysis_data,
              pronunciation_dictionary: pronunciation_dictionary,
              reminder_max_count: reminder_max_count,
              reminder_trigger_ms: reminder_trigger_ms,
              responsiveness: responsiveness&.to_f,
              voice_model: voice_model,
              voice_speed: voice_speed&.to_f,
              voice_temperature: voice_temperature&.to_f,
              voicemail_detection_timeout_ms: voicemail_detection_timeout_ms,
              voicemail_message: voicemail_message,
              volume: volume&.to_f,
              webhook_url: webhook_url
            }.compact

            options = @client.make_request_options(
              extra_headers: extra_headers,
              extra_query: extra_query,
              extra_body: extra_body,
              timeout: timeout
            )

            @client.post('/create-agent', payload, **options)
          end

          def retrieve(
            agent_or_id,
            extra_headers: nil,
            extra_query: nil,
            extra_body: nil,
            timeout: nil
          )
            agent_id = agent_or_id.is_a?(Retell::SDK::Unofficial::Agent) ? agent_or_id.agent_id : agent_or_id

            options = @client.make_request_options(
              extra_headers: extra_headers,
              extra_query: extra_query,
              extra_body: extra_body,
              timeout: timeout
            )

            @client.get("/get-agent/#{agent_id}", **options)
          end

          def update(
            agent_or_id,
            response_engine: nil,
            voice_id: nil,
            agent_name: nil,
            ambient_sound: nil,
            ambient_sound_volume: nil,
            backchannel_frequency: nil,
            backchannel_words: nil,
            boosted_keywords: nil,
            enable_backchannel: nil,
            enable_voicemail_detection: nil,
            end_call_after_silence_ms: nil,
            fallback_voices: nil,
            fallback_voice_ids: nil,
            interruption_sensitivity: nil,
            language: nil,
            max_call_duration_ms: nil,
            name: nil,
            normalize_for_speech: nil,
            opt_out_sensitive_data_storage: nil,
            post_call_analysis_data: nil,
            pronunciation_dictionary: nil,
            reminder_max_count: nil,
            reminder_trigger_ms: nil,
            responsiveness: nil,
            voice: nil,
            voice_model: nil,
            voice_speed: nil,
            voice_temperature: nil,
            voicemail_detection_timeout_ms: nil,
            voicemail_message: nil,
            volume: nil,
            webhook_url: nil,
            extra_headers: nil,
            extra_query: nil,
            extra_body: nil,
            timeout: nil
          )
            agent_name = agent_name || name
            voice_id = voice_id || voice
            fallback_voice_ids = fallback_voice_ids || fallback_voices

            agent_id = agent_or_id.is_a?(Retell::SDK::Unofficial::Agent) ? agent_or_id.agent_id : agent_or_id
            voice_id = voice_id.is_a?(Retell::SDK::Unofficial::Voice) ? voice_id.voice_id : voice_id
            fallback_voice_ids = fallback_voice_ids.is_a?(Array) ? verify_fallback_voice_ids(fallback_voice_ids) : fallback_voice_ids

            validate_voice_model(voice_model) if voice_model
            validate_ambient_sound(ambient_sound) if ambient_sound
            validate_language(language) if language
            validate_numeric_range(ambient_sound_volume, 'ambient_sound_volume', 0, 1) if ambient_sound_volume
            validate_numeric_range(backchannel_frequency, 'backchannel_frequency', 0, 1) if backchannel_frequency
            validate_numeric_range(interruption_sensitivity, 'interruption_sensitivity', 0, 1) if interruption_sensitivity
            validate_numeric_range(responsiveness, 'responsiveness', 0, 1) if responsiveness
            validate_numeric_range(voice_speed, 'voice_speed', 0.5, 2) if voice_speed
            validate_numeric_range(voice_temperature, 'voice_temperature', 0, 2) if voice_temperature
            validate_numeric_range(volume, 'volume', 0, 2) if volume
            validate_pronunciation_dictionary(pronunciation_dictionary) if pronunciation_dictionary
            validate_post_call_analysis_data(post_call_analysis_data) if post_call_analysis_data

            payload = {
              response_engine: response_engine,
              voice_id: voice_id,
              agent_name: agent_name,
              ambient_sound: ambient_sound,
              ambient_sound_volume: ambient_sound_volume&.to_f,
              backchannel_frequency: backchannel_frequency&.to_f,
              backchannel_words: backchannel_words,
              boosted_keywords: boosted_keywords,
              enable_backchannel: enable_backchannel,
              enable_voicemail_detection: enable_voicemail_detection,
              end_call_after_silence_ms: end_call_after_silence_ms,
              fallback_voice_ids: fallback_voice_ids,
              interruption_sensitivity: interruption_sensitivity&.to_f,
              language: language,
              max_call_duration_ms: max_call_duration_ms,
              normalize_for_speech: normalize_for_speech,
              opt_out_sensitive_data_storage: opt_out_sensitive_data_storage,
              post_call_analysis_data: post_call_analysis_data,
              pronunciation_dictionary: pronunciation_dictionary,
              reminder_max_count: reminder_max_count,
              reminder_trigger_ms: reminder_trigger_ms,
              responsiveness: responsiveness&.to_f,
              voice_model: voice_model,
              voice_speed: voice_speed&.to_f,
              voice_temperature: voice_temperature&.to_f,
              voicemail_detection_timeout_ms: voicemail_detection_timeout_ms,
              voicemail_message: voicemail_message,
              webhook_url: webhook_url
            }.compact

            options = @client.make_request_options(
              extra_headers: extra_headers,
              extra_query: extra_query,
              extra_body: extra_body,
              timeout: timeout
            )

            @client.patch("/update-agent/#{agent_id}", payload, **options)
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
            @client.get('/list-agents', **options)
          end

          def delete(
            agent_or_id,
            extra_headers: nil,
            extra_query: nil,
            extra_body: nil,
            timeout: nil
          )
            agent_id = agent_or_id.is_a?(Retell::SDK::Unofficial::Agent) ? agent_or_id.agent_id : agent_or_id

            options = @client.make_request_options(
              extra_headers: extra_headers,
              extra_query: extra_query,
              extra_body: extra_body,
              timeout: timeout
            )
            @client.delete("/delete-agent/#{agent_id}", **options)
            nil
          end

          private

          def verify_fallback_voice_ids(fallback_voice_ids)
            fallback_voice_ids.map do |voice_or_id|
              voice_or_id.is_a?(Retell::SDK::Unofficial::Voice) ? voice_or_id.voice_id : voice_or_id
            end
          end

          def validate_voice_model(voice_model)
            return if voice_model.nil?
            valid_models = ["eleven_turbo_v2", "eleven_turbo_v2_5", "eleven_multilingual_v2"]
            unless valid_models.include?(voice_model)
              raise ArgumentError, "Invalid voice_model. Must be one of: #{valid_models.join(', ')}"
            end
          end

          def validate_ambient_sound(ambient_sound)
            return if ambient_sound.nil?
            valid_sounds = ["coffee-shop", "convention-hall", "summer-outdoor", "mountain-outdoor", "static-noise", "call-center"]
            unless valid_sounds.include?(ambient_sound)
              raise ArgumentError, "Invalid ambient_sound. Must be one of: #{valid_sounds.join(', ')}"
            end
          end

          def validate_language(language)
            return if language.nil?
            valid_languages = ["en-US", "en-IN", "en-GB", "de-DE", "es-ES", "es-419", "hi-IN", "ja-JP", "pt-PT", "pt-BR", "fr-FR", "multi"]
            unless valid_languages.include?(language)
              raise ArgumentError, "Invalid language. Must be one of: #{valid_languages.join(', ')}"
            end
          end

          def validate_numeric_range(value, param_name, min, max)
            return if value.nil?
            value = value.to_f
            unless value >= min && value <= max
              raise ArgumentError, "#{param_name} must be between #{min} and #{max}"
            end
          end

          def validate_pronunciation_dictionary(pronunciation_dictionary)
            pronunciation_dictionary.each do |entry|
              unless entry.is_a?(Hash) && entry[:word].is_a?(String) && entry[:alphabet].is_a?(String) && entry[:phoneme].is_a?(String)
                raise ArgumentError, "Invalid pronunciation_dictionary entry: #{entry}"
              end
              unless ['ipa', 'cmu'].include?(entry[:alphabet])
                raise ArgumentError, "Invalid alphabet in pronunciation_dictionary: #{entry[:alphabet]}. Must be 'ipa' or 'cmu'."
              end
            end
          end

          def validate_post_call_analysis_data(post_call_analysis_data)
            post_call_analysis_data.each do |data|
              unless data.is_a?(Hash) && data[:type].is_a?(String) && data[:name].is_a?(String) && data[:description].is_a?(String)
                raise ArgumentError, "Invalid post_call_analysis_data entry: #{data}"
              end
              case data[:type]
              when 'string'
                validate_string_analysis_data(data)
              when 'enum'
                validate_enum_analysis_data(data)
              when 'boolean'
                # No additional validation needed for boolean type
              when 'number'
                # No additional validation needed for number type
              else
                raise ArgumentError, "Invalid type in post_call_analysis_data: #{data[:type]}"
              end
            end
          end

          def validate_string_analysis_data(data)
            if data[:examples] && !data[:examples].is_a?(Array)
              raise ArgumentError, "Examples for string type must be an array"
            end
          end

          def validate_enum_analysis_data(data)
            unless data[:choices].is_a?(Array) && !data[:choices].empty?
              raise ArgumentError, "Choices for enum type must be a non-empty array"
            end
          end
        end
      end
    end
  end
end
