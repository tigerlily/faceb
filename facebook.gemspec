# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{facebook}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mathieu Fosse"]
  s.date = %q{2010-03-18}
  s.default_executable = %q{console}
  s.description = %q{Facebook library for Web application}
  s.email = %q{mathieu@tigerlilyapps.com}
  s.executables = ["console"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "bin/console",
     "facebook.gemspec",
     "features/facebook-session.feature",
     "features/step_definitions/facebook-session_steps.rb",
     "features/support/env.rb",
     "lib/facebook.rb",
     "lib/facebook/api.rb",
     "lib/facebook/base.rb",
     "lib/facebook/session.rb",
     "spec/facebook_api_spec.rb",
     "spec/facebook_base_spec.rb",
     "spec/facebook_session_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/pointcom/facebook}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Facebook library for Web application}
  s.test_files = [
    "spec/facebook_api_spec.rb",
     "spec/facebook_base_spec.rb",
     "spec/facebook_session_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>, [">= 0.5.2"])
      s.add_runtime_dependency(%q<rack-facebook>, [">= 0.0.3"])
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_development_dependency(%q<cucumber>, [">= 0"])
      s.add_development_dependency(%q<fakeweb>, [">= 1.2.8"])
    else
      s.add_dependency(%q<httparty>, [">= 0.5.2"])
      s.add_dependency(%q<rack-facebook>, [">= 0.0.3"])
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<cucumber>, [">= 0"])
      s.add_dependency(%q<fakeweb>, [">= 1.2.8"])
    end
  else
    s.add_dependency(%q<httparty>, [">= 0.5.2"])
    s.add_dependency(%q<rack-facebook>, [">= 0.0.3"])
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<cucumber>, [">= 0"])
    s.add_dependency(%q<fakeweb>, [">= 1.2.8"])
  end
end
