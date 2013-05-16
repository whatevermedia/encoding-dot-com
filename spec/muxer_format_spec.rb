require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Encoding.com Muxer Format" do

  it "should have an output attribute of 'muxer'" do
    EncodingDotCom::MuxerFormat.new.output.should == "muxer"
  end

  it "should produce a format node in the xml output" do
    format_xml.should have_xpath("/format")
  end

  it "should produce an output node in the xml output" do
    format_xml.should have_xpath("/format/output[text()='muxer']")
  end

  it "should produce a target node in the xml output" do
    format_xml(target: 'ntsc-dvd').should have_xpath("/format/target[text()='ntsc-dvd']")
  end

  it "should produce a maps node in the xml output" do
    format_xml(maps: "0:0,1:0").should have_xpath("/format/maps[text()='0:0,1:0']")
  end

  it "should produce a destination node in the output" do
    format_xml.should have_xpath("/format/destination[text()='http://example.com']")
  end

  describe "valid formats" do
    it "should have one of the supported targets" do
      lambda { EncodingDotCom::MuxerFormat.new(target: 'ntsc-dvd') }.should_not raise_error
      lambda { EncodingDotCom::MuxerFormat.new(target: 'foo') }.should raise_error(EncodingDotCom::IllegalFormatAttribute)
    end

    it "should have maps correctly formatted" do
      lambda { EncodingDotCom::MuxerFormat.new(maps: "0:0,1:0") }.should_not raise_error
      lambda { EncodingDotCom::MuxerFormat.new(maps: "0:0,1:foo") }.should raise_error(EncodingDotCom::IllegalFormatAttribute)
    end
  end

  def format_xml(attributes={})
    attributes[:destination] = "http://example.com"
    format = EncodingDotCom::MuxerFormat.new(attributes)
    Nokogiri::XML::Builder.new {|b| format.build_xml(b)}.to_xml
  end
end
