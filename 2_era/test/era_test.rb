require 'minitest/autorun'
require_relative '../lib/era.rb'

class EraTest < Minitest::Test

  def setup
    @era = Era.new
  end

  def test_era1
    assert_equal '平成11年', @era.calc(1999, 2, 17)
  end

end
