require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module FaceB
  describe FbConnectGenerator do
    before do
      @destination = TMP_DIR
      @source = FbConnectGenerator.source_root
    end
    
    after do
      FileUtils.rm_rf(@destination)
    end
    
    it "should create xd_receiver file" do
      FbConnectGenerator.start([], :destination_root => @destination)
      file = File.join(TMP_DIR, 'public', 'xd_receiver.html')
      File.exists?(file).should be_true
      IO.read(file).should =~ %r{http://static.ak.connect.facebook.com/js/api_lib/v0.4/XdCommReceiver.js}
    end
    
    it "should create xd_receiver file with SSL support" do
      FbConnectGenerator.start(['--ssl'], :destination_root => @destination)      
      file = File.join(TMP_DIR, 'public', 'xd_receiver_ssl.html')
      File.exists?(file).should be_true
      IO.read(file).should =~ %r{https://ssl.connect.facebook.com/js/api_lib/v0.4/XdCommReceiver.js}
    end
  end
end