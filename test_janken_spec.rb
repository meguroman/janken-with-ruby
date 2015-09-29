require 'minitest/autorun'
require File.expand_path('../janken.rb', __FILE__)

describe Janken do
  before do
    @janken = Janken.new
  end
  
  it { %w[g c p].must_include @janken.get_com_hand }


end
