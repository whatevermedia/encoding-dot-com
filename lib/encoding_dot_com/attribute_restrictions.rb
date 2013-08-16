module EncodingDotCom
  module AttributeRestrictionsZune #:nodoc:
    def validate_size
      allowed_sizes = %w{320x120 320x180 320x0 0x120 0x180}
      unless size.nil? || allowed_sizes.include?(size)
        raise IllegalFormatAttribute.new("Size can only be one of #{allowed_sizes.join(',')} but was #{size}")
      end
    end
  end

  module AttributeRestrictionsIpod #:nodoc:
    def validate_size
      allowed_sizes = %w{320x240 640x480}
      unless size.nil? || allowed_sizes.include?(size)
        raise IllegalFormatAttribute.new("Size can only be one of #{allowed_sizes.join(',')} but was #{size}")
      end
    end
  end

  module AttributeRestrictionsFlv #:nodoc:
#    validate_inclusion_of :audio_bitrate, %w{32k 40k 48k 56k 64k 80k 96k 112k 128k 144k 160k 192k 224k 256k 320k}
#    validate_inclusion_of :video_codec, %w{flv libx264 vp6}
    
    def validate_audio_bitrate
      allowed_bitrates = %w{32k 40k 48k 56k 64k 80k 96k 112k 128k 144k 160k 192k 224k 256k 320k}
    end
    
    def validate_video_codec
      allowed_codecs = %w{flv libx264 vp6}
      unless video_codec.nil? || allowed_codecs.include?(video_codec)
        raise IllegalFormatAttribute.new("Video codec can only be one of #{allowed_codecs.join(',')} but was #{video_codec}")
      end
    end
  end

  module AttributeRestrictionsMp4 #:nodoc:
    def validate_video_codec
      allowed_codecs = %w{mpeg4 libx264}
      unless video_codec.nil? || allowed_codecs.include?(video_codec)
        raise IllegalFormatAttribute.new("Video codec can only be one of #{allowed_codecs.join(',')} but was #{video_codec}")
      end
    end
  end

  module AttributeRestrictionsFl9 #:nodoc:
  end

  module AttributeRestrictionsWmv #:nodoc:
  end

  module AttributeRestrictionsMov #:nodoc:
  end

  module AttributeRestrictions3gp #:nodoc:
  end
  
  module AttributeRestrictionsM4v #:nodoc:
  end

  module AttributeRestrictionsIphone #:nodoc:
  end
  
  module AttributeRestrictionsIpad #:nodoc:
  end

  module AttributeRestrictionsAndroid #:nodoc:
  end

  module AttributeRestrictionsOgg #:nodoc:
  end

  module AttributeRestrictionsWebm #:nodoc:
  end
  
  module AttributeRestrictionsAppletv #:nodoc:
  end

  module AttributeRestrictionsPsp #:nodoc:
  end
  
  module AttributeRestrictionsMp3 #:nodoc:
  end
  
  module AttributeRestrictionsWma #:nodoc:
  end

  module AttributeRestrictionsM4a #:nodoc:
  end

  module AttributeRestrictionsMpeg1 #:nodoc:
  end

  module AttributeRestrictionsMpeg2 #:nodoc:
  end

  module AttributeRestrictionsIphoneStream #:nodoc:
  end

  module AttributeRestrictionsIpadStream #:nodoc:
  end

  module AttributeRestrictionsmuxer #:nodoc:
  end

  module AttributeRestrictionsWowza #:nodoc:
  end

  module AttributeRestrictionsMultibitrate #:nodoc:
  end

  module AttributeRestrictionsRoku800 #:nodoc:
  end

  module AttributeRestrictionsRoku1200 #:nodoc:
  end

  module AttributeRestrictionsRoku1800 #:nodoc:
  end

  module AttributeRestrictionsRoku2700 #:nodoc:
  end

  module AttributeRestrictionsRokuHls #:nodoc:
  end

  module AttributeRestrictionsMpegts #:nodoc:
  end

  module AttributeRestrictionsDnxhd #:nodoc:
  end

  module AttributeRestrictionsVidly #:nodoc:
  end

  module AttributeRestrictionsVidlyLite #:nodoc:
  end

  module AttributeRestrictionsKindleFire #:nodoc:
  end

  module AttributeRestrictionsEac3 #:nodoc:
  end

  module AttributeRestrictionsSmoothStreaming #:nodoc:
  end

  module AttributeRestrictionsHds #:nodoc:
  end
  
  module AttributeRestrictionsThumbnail #:nodoc:
  end
end
