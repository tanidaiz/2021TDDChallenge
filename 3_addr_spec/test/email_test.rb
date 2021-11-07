require 'minitest/autorun'
require_relative '../lib/validate_addr_spec.rb'
require "stringio"

class ValidationTest < Minitest::Test

  def setup
    @validation = Validation.new
  end

  def stdin_string_io(string)
    input = StringIO.new(string)
    output = StringIO.new

    @validation.validate(input, output)

    return output.string
  end

  def test_ex1
    assert_equal "ok\n", stdin_string_io("abc@example.com\n")
  end
  
  def test_ex2
    assert_equal "ng\n", stdin_string_io("a..bc@example.com\n")
  end

  def test_d1
    assert_equal "ok\n", stdin_string_io("ABCabc@hoge.!#$%&'*+-/=?^_`{|}~.com\n")
  end

  def test_d2
    assert_equal "ng\n", stdin_string_io("abc@.example.com")
  end

  def test_d3
    assert_equal "ng\n", stdin_string_io("abc@com.")
  end

  def test_d4
    assert_equal "ng\n", stdin_string_io("abc@example..com")
  end

  def test_d5
    assert_equal "ng\n", stdin_string_io("abc@")
    assert_equal "ok\n", stdin_string_io("abc@d")
  end

  def test_a1
    assert_equal "ng\n", stdin_string_io("abc@@example.com")
  end

  def test_ld1
    assert_equal "ok\n", stdin_string_io("hoge.!#$%&'*+-/=?^_`{|}~@example.com\n")
  end

  def test_ld2
    assert_equal "ng\n", stdin_string_io(".hoge@example.com")
  end
  
  def test_ld3
    assert_equal "ng\n", stdin_string_io("hoge.@example.com")
  end
  
  def test_ld4
    assert_equal "ng\n", stdin_string_io("hoge..fuga@example.com")
  end
  
  def test_ld5
    assert_equal "ng\n", stdin_string_io("@example.com")
  end

  def test_lq1
    assert_equal "ng\n", stdin_string_io('hoge"@example.com')
  end

  def test_lq2
    assert_equal "ng\n", stdin_string_io('"hoge@example.com')
  end

  def test_lq3
    text = <<~EOF
      "!#$%&'*+-/=?^_`{|}~(),.:;<>@[]"\"@example.com
    EOF
    assert_equal "ok\n", stdin_string_io(text)
  end

  # def test_lq4
  #   assert_equal "ng\n", stdin_string_io('@example.com')
  # end

  def test_lq5
    assert_equal "ok\n", stdin_string_io('""@example.com')
    assert_equal "ng\n", stdin_string_io('"@example.com')
  end
end
