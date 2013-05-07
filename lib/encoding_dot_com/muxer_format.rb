module EncodingDotCom
  # A Muxer output format
  class MuxerFormat < Format #:nodoc:
    allowed_attributes :output, :target, :maps, :destination

    # Creates a new MuxerFormat. You should be calling
    # Format.create(attributes) rather than this constructor directly.
    def initialize(attributes={})
      attributes = EncodingDotCom::VideoFormat.sanitize_attributes attributes
      @attributes = attributes.merge("output" => "muxer")
      validate_attributes
    end

    def validate_attributes
      validate_target
      validate_maps
    end

    private

    def validate_target
      return if target.nil?
      allowed_targets = ["pal-vcd", "pal-svcd", "pal-dvd", "pal-dv", "pal-dv50", "ntsc-vcd", "ntsc-svcd", "ntsc-dvd", "ntsc-dv", "ntsc-dv50", "film-vcd", "film-svcd", "film-dvd", "film-dv", "film-dv50"]
      if !allowed_targets.include?(target)
        raise IllegalFormatAttribute.new("Target must be one one of the following values: pal-vcd, pal-svcd, pal-dvd, pal-dv, pal-dv50, ntsc-vcd, ntsc-svcd, ntsc-dvd, ntsc-dv, ntsc-dv50, film-vcd, film-svcd, film-dvd, film-dv, film-dv50")
      end
    end

    def validate_maps
      return if maps.nil?
      if !maps.match(/\d:\d,\s*\d:\d/)
        raise IllegalFormatAttribute.new("Maps must be in the format 'file#:track#, file#:track#'")
      end
    end
  end
end

