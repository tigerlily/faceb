Dir[File.dirname(__FILE__) + '/generators/**/*_generator.rb'].each { |generator| 
  require generator
}
