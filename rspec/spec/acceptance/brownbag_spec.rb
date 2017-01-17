require 'spec_helper_acceptance'

describe file('/opt/brownbag') do
  it { is_expected.to be_directory }
end

describe file('/etc/puppet/modules') do
  it { is_expected.to be_directory }
end

describe 'brownbag' do
  let(:pp) do
    <<-EOS
      class { 'brownbag':
        configuration_file_path   => '/etc/brownbag.conf',
        configuration_file_values => {
          key1 => 'value1',
          key2 => 'value2'
        }
      }
    EOS
  end

  it 'should run without errors' do
    expect(apply_manifest(pp, catch_failures: true).exit_code).to eq 2
  end

  # it 'should delete accounts' do
  #   grants_results = shell("mysql -e 'show grants for root@127.0.0.1;'")
  #   expect(grants_results.exit_code).to eq 1
  # end

  # it 'should delete databases' do
  #   show_result = shell("mysql -e 'show databases;'")
  #   expect(show_result.stdout).not_to match /test/
  # end

  it 'should run a second time without changes' do
    expect(apply_manifest(pp, catch_failures: true).exit_code).to eq 0
  end

  # describe package('mysql-server') do
  #   it { is_expected.to be_installed }
  # end
end
