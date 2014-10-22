describe ManageController do
  describe '.check_ownership' do

    ##
    # Subclasses of Managecontroller MUST implement this method
    ##
    it 'fails with RuntimeError' do
      expect { subject.check_ownership }.to raise_error(RuntimeError)
    end
  end
end
