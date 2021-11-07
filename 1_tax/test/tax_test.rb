require 'minitest/autorun'
require_relative '../lib/tax.rb'

class TaxTest < Minitest::Test

  def setup
    @tax = Tax.new
  end

  def test_tax1
    assert_equal 24, @tax.calc([10, 12])
  end

  def test_tax2
    assert_equal 62, @tax.calc([40, 16])
  end

  def test_tax3
    assert_equal 160, @tax.calc([100, 45])
  end

  def test_tax4
    assert_equal 171, @tax.calc([50, 50, 55])
  end

  def test_tax5
    assert_equal 0, @tax.calc([])
  end

end
