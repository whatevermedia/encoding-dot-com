module EncodingDotCom
  class VideoFormat < Format #:nodoc:
    ALLOWED_OUTPUT_FORMATS = %w{flv fl9 wmv 3gp mp4 m4v ipad ipod iphone appletv psp zune mp3 wma}.freeze

    ##Api Output Format Fields
    #Video Outputs
    allowed_attributes :output
    #VP6 FLV Output
    allowed_attributes :vp6_profile, :noise_reduction, :upct, :kfinttype, :keyframe, :sharpness, :cxmode
    #Video Settings
    allowed_attributes :size, :video_codec, :set_aspect_ratio, :bitrate, :maxrate, :minrate, :cbr, :framerate, :framerate_upper_threshold, :keyframe, :start, :duration
    boolean_attributes :keep_aspect_ratio, :cbr
    #Audio Settings
    allowed_attributes :audio_codec, :audio_bitrate, :audio_sample_rate, :audio_channels_number, :audio_volume, :audio_normalization, :audio_sync
    boolean_attributes :acbr
    #Output Destinations
    allowed_attributes :destination
    #Other Output Format Options
    allowed_attributes :profile, :two_pass_decoding, :bufsize, :rc_init_occupancy, :force_interlaced, :preset, :bframes, :gop, :luma_spatial, :chroma_spatial, :luma_temp, :video_sync
    boolean_attributes :two_pass, :deinterlacing, :add_meta, :hint, :strip_chapters
    #Turbo and Twin-Turbo Encoding
    boolean_attributes :turbo, :twin_turbo
    #Global Processing Regions
    allowed_attributes :region

    ##Adaptive Bitrate Encoding##
    #TODO: add support for adaptive bitrate encoding

    ##Advanced H.264 Parameters##
    #Frame-Type Options
    allowed_attributes :keyint_min, :sc_threshold, :bf, :b_strategy, :flags2, :coder, :refs, :flags, :deblockalpha, :deblockbeta
    #Ratecontrol
    allowed_attributes :cqp, :crf, :qmin, :qmax, :qdiff, :bt, :i_qfactor, :b_qfactor, :chromaoffset, :pass, :rc_eq, :qcomp, :complexityblur, :qblur
    #Analysis
    allowed_attributes :partitions, :directpred, :flags2, :me_method, :me_range, :subq, :trellis

    ##Editing Features##
    #Watermarking
    allowed_attributes :logo, :logo_source, :logo_x, :logo_y, :logo_mode, :logo_threshold
    #Closed Captions
    allowed_attributes :closed_captions, :source, :mux_type, :language, :extract, :time_offset
    boolean_attributes :copy
    #Creating Thumbnails: See thumbnail_format.rb
    #Video Rotation
    allowed_attributes :rotate, :set_rotate
    #Cropping
    allowed_attributes :crop_top, :crop_left, :crop_right, :crop_bottom
    #Fadding
    allowed_attributes :fade_in, :fade_out
    #Muxing: See muxing_format.rb
    #Meta Data
    allowed_attributes :metadata, :author, :title, :album, :description, :copyright, :copy
    #Video Overlay
    allowed_attributes :overlay, :overlay_source, :overlay_x, :overlay_y, :size, :overlay_start, :overlay_duration
    #Text Overlay
    allowed_attributes :text_overlay, :text, :font_source, :font_size, :font_rotate, :font_color, :align_center, :overlay_x, :overlay_y, :size, :overlay_start, :overlay_duration


    def initialize(attributes={})
      @attributes = attributes
      check_valid_output_format
      mixin_output_attribute_restrictions
      validate_attributes
    end

    private

    def check_valid_output_format
      unless ALLOWED_OUTPUT_FORMATS.include?(@attributes["output"])
        raise IllegalFormatAttribute.new("Output format #{@attributes["output"]} is not allowed.")
      end
    end

    def mixin_output_attribute_restrictions
      module_name = "AttributeRestrictions#{@attributes["output"].capitalize}"
      restrictions = EncodingDotCom.const_get(module_name)
      (class << self; self; end).send(:include, restrictions)
    end

    def validate_attributes
      validate_video_codec
      validate_size
    end

    def validate_size
    end

    def validate_video_codec
    end
  end
end
