# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{encoding-dot-com}
  s.version = "0.0.7.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Roland Swingler}, %q{Alan Kennedy}, %q{Levent Ali}]
  s.date = %q{2011-11-04}
  s.description = %q{A ruby wrapper for the encoding.com API}
  s.email = %q{roland.swingler@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "Gemfile",
     "Gemfile.lock",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "encoding-dot-com.gemspec",
     "lib/encoding-dot-com.rb",
     "lib/encoding_dot_com.rb",
     "lib/encoding_dot_com/attribute_restrictions.rb",
     "lib/encoding_dot_com/errors.rb",
     "lib/encoding_dot_com/flv_vp6_format.rb",
     "lib/encoding_dot_com/format.rb",
     "lib/encoding_dot_com/http_adapters/curb_adapter.rb",
     "lib/encoding_dot_com/http_adapters/net_http_adapter.rb",
     "lib/encoding_dot_com/image_format.rb",
     "lib/encoding_dot_com/media_info.rb",
     "lib/encoding_dot_com/media_list_item.rb",
     "lib/encoding_dot_com/media_status_report.rb",
     "lib/encoding_dot_com/queue.rb",
     "lib/encoding_dot_com/response.rb",
     "lib/encoding_dot_com/notify_response.rb",
     "lib/encoding_dot_com/thumbnail_format.rb",
     "lib/encoding_dot_com/video_format.rb",
     "spec/encoding_dot_com/http_adapters/curb_adapter_spec.rb",
     "spec/encoding_dot_com/http_adapters/net_http_adapter_spec.rb",
     "spec/flv_vp6_format_spec.rb",
     "spec/format_spec.rb",
     "spec/image_format_spec.rb",
     "spec/media_list_item_spec.rb",
     "spec/queue_spec.rb",
     "spec/spec_helper.rb",
     "spec/thumbnail_format_spec.rb"
  ]
  s.homepage = %q{http://encodingdotcom.rubyforge.org/}
  s.rdoc_options = [%q{--charset=UTF-8}]
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{A ruby wrapper for the encoding.com API}
  s.test_files = [
    "spec/encoding_dot_com/http_adapters/curb_adapter_spec.rb",
     "spec/encoding_dot_com/http_adapters/net_http_adapter_spec.rb",
     "spec/flv_vp6_format_spec.rb",
     "spec/format_spec.rb",
     "spec/image_format_spec.rb",
     "spec/media_list_item_spec.rb",
     "spec/queue_spec.rb",
     "spec/spec_helper.rb",
     "spec/thumbnail_format_spec.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<nokogiri>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<nokogiri>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end

