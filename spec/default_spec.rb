require 'chefspec'

describe 'integrity-client::default' do
  
  let(:chef_run) do
    runner = ChefSpec::ChefRunner.new('platform' => 'ubuntu', 'version'=> '12.04')
    runner.converge('integrity-client::default')
  end
    
  it 'should include the integrity-client recipe by default' do
    expect(chef_run).to include_recipe 'integrity-client::default'
  end

end
