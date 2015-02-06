require 'spec_helper'
describe 'bro' do

  context 'with defaults for all parameters' do
    it { should contain_class('bro') }
  end
end
