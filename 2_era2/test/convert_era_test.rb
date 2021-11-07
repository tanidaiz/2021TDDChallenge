require 'minitest/autorun'
require_relative '../lib/convert_era.rb'
require "stringio"

class ConvertEraTest < Minitest::Test

  def setup
    @era = ConvertEra.new
  end

  def stdin_string_io(string)
    input = StringIO.new(string)
    output = StringIO.new

    @era.convert(input, output)
    
    return output.string
  end

  def test_era_before_showa
    assert_equal "error\n", stdin_string_io("1920/12/25\n")
  end
  
  def test_era_before_showa_edge
    assert_equal "error\n", stdin_string_io("1926/12/24\n")
  end

  def test_era_showa_start
    assert_equal "昭和元年\n", stdin_string_io("1926/12/25\n")
  end

  def test_era_showa_middle
    assert_equal "昭和32年\n", stdin_string_io("1957/6/15\n")
  end
  
  def test_era_showa_end
    assert_equal "昭和64年\n", stdin_string_io("1989/1/7\n")
  end
  
  def test_era_heisei_start
    assert_equal "平成元年\n", stdin_string_io("1989/1/8\n")
  end

  def test_era_heisei_middle
    assert_equal "平成12年\n", stdin_string_io("2000/5/14\n")
  end

  def test_era_heisei_end
    assert_equal "平成31年\n", stdin_string_io("2019/4/30\n")
  end
  
  def test_era_reiwa_start
    assert_equal "令和元年\n", stdin_string_io("2019/5/1\n")
  end

  def test_era_reiwa_middle
    assert_equal "令和2年\n", stdin_string_io("2020/7/16\n")
  end

  def test_era_reiwa_continue
    assert_equal "令和20年\n", stdin_string_io("2038/4/30\n")
  end

  def test_final
  input = <<~EOF
    1989/1/7
    1989/1/8
    1993/1/5
    1926/12/23

    1963/7/21

  EOF
  output = <<~EOF
    昭和64年
    平成元年
    平成5年
    error
    error
    昭和38年
    error
  EOF
  assert_equal output, stdin_string_io(input)
  end

end
