require 'minitest/autorun'
require_relative '../lib/era.rb'

class EraTest < Minitest::Test

  def setup
    @era = Era.new
  end


  def test_era_showa_start
    assert_equal '昭和元年', @era.calc(1926, 12, 25)
  end

  def test_era_showa_middle
    assert_equal '昭和32年', @era.calc(1957, 6, 15)
  end
  
  def test_era_showa_end
    assert_equal '昭和64年', @era.calc(1989, 1, 7)
  end
  
  def test_era_heisei_start
    assert_equal '平成元年', @era.calc(1989, 1, 8)
  end

  def test_era_heisei_middle
    assert_equal '平成12年', @era.calc(2000, 5, 14)
  end

  def test_era_heisei_end
    assert_equal '平成31年', @era.calc(2019, 4, 30)
  end
  
  def test_era_reiwa_start
    assert_equal '令和元年', @era.calc(2019, 5, 1)
  end

  def test_era_reiwa_middle
    assert_equal '令和2年', @era.calc(2020, 7, 16)
  end

  def test_era_reiwa_continue
    assert_equal '令和20年', @era.calc(2038, 4, 30)
  end

end
