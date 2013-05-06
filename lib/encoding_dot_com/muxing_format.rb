module EncodingDotCom
  # A Thumbnail output format
  class MuxingFormat < Format #:nodoc:
    allowed_attributes :output, :target, :maps, :destination

    # Creates a new ThumbnailFormat. You should be calling
    # Format.create(attributes) rather than this constructor directly.
    def initialize(attributes={})
      @attributes = attributes.merge("output" => "muxer")
      validate_attributes
    end

    def validate_attributes
    end
  end
end

