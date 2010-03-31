require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module FaceB
  describe ConfigGenerator do
    before do
      @destination = TMP_DIR
      @config_file = File.join(@destination, 'config', 'faceb.yml')
      @source = ConfigGenerator.source_root
    end
    
    after do
      FileUtils.rm_rf(@destination)
    end
    
    it "should copy Faceb config file" do
      ConfigGenerator.start([], :destination_root => @destination)
      File.exists?(@config_file).should be_true
    end
    
    it "should accept options" do
      ConfigGenerator.start(['--api-key=my-api-key', '--secret-key=my-secret-key'], :destination_root => @destination)
      
      File.exists?(@config_file).should be_true
      file_content = IO.read(@config_file)
      file_content.should =~ /api_key: my-api-key/
      file_content.should =~ /secret_key: my-secret-key/
    end
  end
end