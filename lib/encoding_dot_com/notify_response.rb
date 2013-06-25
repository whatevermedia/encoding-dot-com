module EncodingDotCom
  class NotifyResponse < Response

    attr_reader :description, :formats, :source

    def initialize(xml)
      super(xml)
      @status = value_at_node 'result/status'
      @result = value_at_node 'result'
      @description = value_at_node 'result/description'
      @formats = document.xpath '//format'
      @source = value_at_node 'result/source'
    end

    # Get destinations returned from encoding
    #
    # +block+:: yields destination, status, and output for each format to allow custom implementation of nodes
    # If not block given, returns formats node
    def get_destinations(&block)
      return formats unless block_given?
      formats.each do |format|
        yield format.xpath('destination').text, format.xpath('status').text, format.xpath('output').text
      end
    end
  end
end