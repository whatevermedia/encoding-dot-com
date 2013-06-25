module EncodingDotCom
  class NotifyResponse < Response

    attr_reader :description, :formats, :source

    def initialize(xml)
      super(xml)
      @description = value_at_node '//description'
      @formats = document.xpath '//format'
      @source = value_at_node '//source'
    end

    # Get destinations returned from encoding
    #
    # +block+:: yields destination, status, and output for each format to allow custom implementation of nodes
    def get_destinations(&block)
      formats.each do |format|
        yield format.xpath('destination').text, format.xpath('status').text, format.xpath('output').text
      end
    end
  end
end