require 'nokogiri'

module EncodingDotCom
  class Response

    attr_reader :document, :status, :result

    # Creates a new Nokogiri document and parses some relevant information
    #
    # +xml+:: XML response returned from encoding.com
    # +document+:: Nokogiri document parsed from XML
    # +status+:: status parsed from status node
    # +result!:: result node from document
    def initialize(xml)
      @xml          = xml
      @document     = nil
      @status       = nil
      @result       = nil

      parse_xml
    end

    # Check to see if status of response is Error
    def error?
      @status.downcase.eql? 'error'
    end

    # Check to see if status of response is Finished
    def finished?
      @status.downcase.eql? 'finished'
    end

    # Check to see if status of response is Success
    def successful?
      @status.downcase.eql? 'success'
    end

    # Get the text value at a node in the document
    #
    # +node+:: Node in the document to get the text value from
    def value_at_node(node)
      document.xpath(node).text
    end

    protected

    # Parses xml response and sets up document with some other information
    def parse_xml
      @document = Nokogiri::XML @xml
      @document = @xml if @xml.is_a? Nokogiri::XML::Document
      @status = value_at_node 'response/status'
      @status = value_at_node 'result/status' if status.empty?
      @result = value_at_node 'response/result'
      @result = value_at_node 'result' if result.empty?
    end
  end
end