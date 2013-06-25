require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Encoding.com response parser" do
  # <?xml version=\"1.0\"?>
  # <response>
  #   <status>Error</status>
  # </response>
  context 'xml with status only' do
    def build_simple_xml
      "<?xml version=\"1.0\"?><response><status>Error</status></response>"
    end

    let(:xml) { build_simple_xml }

    it 'should call parse_xml on initialize' do
      EncodingDotCom::Response.any_instance.should_receive(:parse_xml)
      EncodingDotCom::Response.new(xml)
    end

    it 'parse_xml should call value_at_node twice' do
      EncodingDotCom::Response.any_instance.should_receive(:value_at_node).exactly(2).times
      EncodingDotCom::Response.new(xml)
    end

    let(:response) { EncodingDotCom::Response.new(xml) }
    subject { response }

    its(:document) { should_not be_nil }
    its(:status) { should_not be_nil }
    its(:result) { should be_empty }

    context 'with existing document' do
      it 'should use document from existing nokogiri document' do
        doc = Nokogiri::XML(build_simple_xml)
        response = EncodingDotCom::Response.new(doc)
        response.document.should == doc
      end
    end

    context 'response status' do
      def xml_with_status(status)
        "<?xml version=\"1.0\"?><response><status>#{status}</status></response>"
      end

      context 'error' do
        let(:xml) { xml_with_status('Error') }
        let(:response) { EncodingDotCom::Response.new(xml) }

        it 'response.status should == Error' do
          response.status.should == 'Error'
        end

        it { response.should be_error }
        it { response.should_not be_successful }
        it { response.should_not be_finished }
      end

      context 'success' do
        let(:xml) { xml_with_status('Success') }
        let(:response) { EncodingDotCom::Response.new(xml) }

        it 'response.status should == Success' do
          response.status.should == 'Success'
        end

        it { response.should be_successful }
        it { response.should_not be_error }
        it { response.should_not be_finished }
      end

      context 'finished' do
        let(:xml) { xml_with_status('Finished') }
        let(:response) { EncodingDotCom::Response.new(xml) }

        it 'response.status should == Finished' do
          response.status.should == 'Finished'
        end

        it { response.should be_finished }
        it { response.should_not be_successful }
        it { response.should_not be_error }
      end

    end
  end

  # <?xml version=\"1.0\"?>
  # <response>
  #   <mediaid>1234</mediaid>
  #   <source>www.example.com</source>
  #   <status>Error</status>
  #   <description>Download error:  The requested URL returned error: 400</description>
  #   <result>
  #     <user_id>12345</user_id>
  #   </result>
  #   <format>
  #     <id>987</id>
  #     <status>New</status>
  #   </format>
  # </response>
  context 'complex xml' do
    def nokogiri_doc(xml)
      Nokogiri::XML(xml)
    end

    let(:xml) { '<?xml version=\"1.0\"?><response><mediaid>1234</mediaid><source>www.example.com</source><status>Error</status><description>Download error:  The requested URL returned error: 400</description><result><user_id>12345</user_id></result><format><id>987</id><status>New</status></format></response>' }
    let(:response) { EncodingDotCom::Response.new(xml) }
    let(:doc) { nokogiri_doc(xml) }
    subject { response }

    its(:document) { should_not be_nil }
    its(:result) { should_not be_nil }
    its(:status) { should_not be_nil }

    describe '#value_at_node' do
      its 'response/status should equal response#status' do
        response.value_at_node('response/status').should == response.status
      end

      its 'description should be text at description node' do
        response.value_at_node('response/description').should == doc.xpath('response/description').text
      end

      its 'source should be value at source node' do
        response.value_at_node('response/source').should == doc.xpath('response/source').text
      end
    end

  end

end