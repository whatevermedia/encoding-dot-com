require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Encoding.com notify response parser" do

  # <?xml version=\"1.0\"?>
  # <result>
  #   <status>Error</status>
  # </result>
  context 'simple xml response' do
    def build_simple_xml
      "<?xml version=\"1.0\"?><result><status>Error</status></result>"
    end

    let(:xml) { build_simple_xml }

    it 'parse_xml should call value_at_node six times' do
      EncodingDotCom::NotifyResponse.any_instance.should_receive(:value_at_node).exactly(6).times
      EncodingDotCom::NotifyResponse.new(xml)
    end

    let(:response) { EncodingDotCom::NotifyResponse.new(xml) }
    subject { response }

    its(:document) { should_not be_nil }
    its(:status) { should_not be_empty }
    its(:result) { should_not be_empty }
    its(:description) { should be_empty }
    its(:formats) { should be_empty }
    its(:source) { should be_empty }

    context 'with existing document' do
      it 'should use document from existing nokogiri document' do
        doc = Nokogiri::XML(build_simple_xml)
        response = EncodingDotCom::NotifyResponse.new(doc)
        response.document.should == doc
      end
    end

    context 'response status' do
      def xml_with_status(status)
        "<?xml version=\"1.0\"?><result><status>#{status}</status></result>"
      end

      context 'error' do
        let(:xml) { xml_with_status('Error') }
        let(:response) { EncodingDotCom::NotifyResponse.new(xml) }
        subject { response }

        its(:status) { should == 'Error' }
        it { should be_error }
        it { should_not be_successful }
        it { should_not be_finished }
      end

      context 'success' do
        let(:xml) { xml_with_status('Success') }
        let(:response) { EncodingDotCom::NotifyResponse.new(xml) }
        subject { response }

        its(:status) { should == 'Success' }
        it { should be_successful }
        it { should_not be_error }
        it { should_not be_finished }
      end

      context 'finished' do
        let(:xml) { xml_with_status('Finished') }
        let(:response) { EncodingDotCom::NotifyResponse.new(xml) }
        subject { response }

        its(:status) { should == 'Finished' }
        it { should be_finished }
        it { should_not be_successful }
        it { should_not be_error }
      end

    end
  end

  # <?xml version=\"1.0\"?>
  # <result>
  #   <mediaid>1234</mediaid>
  #   <source>www.example.com</source>
  #   <status>Error</status>
  #   <description>Download error:  The requested URL returned error: 400</description>
  #   <format>
  #     <id>987</id>
  #     <status>New</status>
  #     <destination>www.example.com</destination>
  #   </format>
  #   <format>
  #     <id>986</id>
  #     <status>New</status>
  #     <destination>www.example.com</destination>
  #   </format>
  #   <format>
  #     <id>985</id>
  #     <status>New</status>
  #     <destination>www.example.com</destination>
  #   </format>
  # </result>
  context 'complex xml' do
    def nokogiri_doc(xml)
      Nokogiri::XML(xml)
    end

    def build_formats(num_formats)
      formats = '<result>'
      num_formats.times do |num|
        formats << "<format><id>#{num+1}</id><status>New</status><destination>www.example.com</destination><output>mp4</output></format>"
      end
      formats << '</result>'
      doc = Nokogiri::XML formats
      doc.xpath('//format')
    end

    let(:xml) { '<?xml version=\"1.0\"?><result><mediaid>1234</mediaid><source>www.example.com</source><status>Error</status><description>Download error:  The requested URL returned error: 400</description><format><id>987</id><status>New</status></format><format><id>986</id><status>New</status></format><format><id>985</id><status>New</status></format></result>' }
    let(:response) { EncodingDotCom::NotifyResponse.new(xml) }
    let(:doc) { nokogiri_doc(xml) }
    subject { response }

    its(:document) { should_not be_nil }
    its(:result) { should_not be_empty }
    its(:status) { should_not be_empty }
    its(:source) { should_not be_empty }
    its(:description) { should_not be_empty }
    its(:formats) { should_not be_empty }

    describe '#value_at_node' do
      its 'result/status should equal response#status' do
        response.value_at_node('result/status').should == response.status
      end

      its 'result/source should == response#source' do
        response.value_at_node('result/source').should == response.source
      end

      its 'result/description should == response#description' do
        response.value_at_node('result/description').should == response.description
      end

    end

    describe '#get_each_format' do
      context 'no block given' do
        it 'should return formats with no block given' do
          response.get_each_format.should == response.formats
        end

        it 'should return same format block calling get_each_format#first' do
          response.get_each_format.first.should == response.formats.first
        end
      end

      context 'block given' do
        before(:each) { response.stub(:formats).and_return(build_formats(3)) }

        it 'should return 3 objects with 3 format blocks' do
          times = []
          response.get_each_format { |format, status| times << format }
          times.count.should == 3
        end

        it 'should yield each status' do
          outputs = []
          response.get_each_format { |format, status| outputs << status }
          outputs.should == ['New', 'New', 'New']
        end

        it 'should yield each format' do
          expected_formats = response.formats.inject([]) { |arr, format| arr << format }
          formats = []
          response.get_each_format { |format, status| formats << format }
          formats.should == expected_formats
        end
      end
    end

  end

end