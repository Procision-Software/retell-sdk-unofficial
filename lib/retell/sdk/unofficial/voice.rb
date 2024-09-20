module Retell
  module SDK
    module Unofficial
      class Voice < Base
        @attributes = [
          :voice_id, :voice_name, :provider, :accent, :gender, :age, :preview_audio_url
        ]

        attr_reader *@attributes

        def retrieve
          @client.voice.retrieve(self)
        end

        def id
          voice_id
        end

        def name
          voice_name
        end
      end
    end
  end
end
