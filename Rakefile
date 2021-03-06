require 'rubygems'
require 'rake'
require 'yard'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "faceb"
    gem.summary = %Q{Facebook library}
    gem.description = %Q{Facebook library}
    gem.email = "mathieu@tigerlilyapps.com"
    gem.homepage = "http://github.com/tigerlily/faceb"
    gem.authors = ["Mathieu Fosse"]
    gem.add_dependency "httparty", ">= 0.5.2"
    gem.add_dependency "rack-facebook", ">= 0.0.3"
    
    # Tests
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.add_development_dependency "cucumber", ">= 0"
    gem.add_development_dependency "fakeweb", ">= 1.2.8"
    gem.add_development_dependency "rr", ">= 0.10.10"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/*_spec.rb']
end

Spec::Rake::SpecTask.new(:spec_rails) do |spec|
  ruby_path = `which ruby`.chomp
  spec.ruby_cmd = "FACEB_TEST=rails #{ruby_path}"
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/rails/*_spec.rb']
end

desc 'Run all FaceB tests.'
task :spec_all => [:spec, :spec_rails]

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

begin
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:features)

  task :features => :check_dependencies
rescue LoadError
  task :features do
    abort "Cucumber is not available. In order to run features, you must: sudo gem install cucumber"
  end
end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "FaceB #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

# Yard
YARD::Rake::YardocTask.new