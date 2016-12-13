shared_examples 'a YAML file' do
  # subject should still be the file object
  it { is_expected.to be_a_file }

  describe 'content' do
    it { expect(subject.content).not_to be_empty }
    it 'should be valid YAML' do
      expect { YAML.load(subject.content) }.not_to raise_error
    end
  end
end
