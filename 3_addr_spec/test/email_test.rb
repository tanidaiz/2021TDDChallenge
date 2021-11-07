require 'minitest/autorun'
require_relative '../lib/validate_addr_spec.rb'
require "stringio"

class ValidationTest < Minitest::Test

  def setup
    @validation = Validation.new
  end

  def entire(mail_address)
    input = StringIO.new(mail_address)
    output = StringIO.new
    @validation.validate(input, output)
    return output.string
  end

  def test_entire
    assert_equal "ok\n", entire("abc@example.com\n")
    assert_equal "ng\n", entire("a..bc@example.com\n")
    assert_equal "ok\n", entire("ABCabc@hoge.!#$%&'*+-/=?^_`{|}~.com\n")
    assert_equal "ng\n", entire("abc@.example.com\n")
    assert_equal "ng\n", entire("abc@com.\n")
    assert_equal "ng\n", entire("abc@example..com\n")
    assert_equal "ng\n", entire("abc@\n")
    assert_equal "ok\n", entire("abc@d\n")

    assert_equal "ng\n", entire("abc@@example.com\n")

    assert_equal "ok\n", entire("hoge.!#$%&'*+-/=?^_`{|}~@example.com\n")
    assert_equal "ng\n", entire(".hoge@example.com\n")
    assert_equal "ng\n", entire("hoge.@example.com\n")
    assert_equal "ng\n", entire("hoge..fuga@example.com\n")
    assert_equal "ng\n", entire("@example.com\n")
    assert_equal "ng\n", entire("hoge\"@example.com\n")
    assert_equal "ng\n", entire("\"hoge@example.com\n")
    text = <<~EOF
      \"!#$%&'*+-/=?^_`{|}~(),.:;<>@[]\"\\\"@example.com
    EOF
    assert_equal "ok\n", entire(text)
    assert_equal "ok\n", entire('""@example.com'+"\n")
    assert_equal "ng\n", entire('"@example.com'+"\n")

  end

  def test_local
    assert_equal true, @validation.validate_local("abc")
    assert_equal true, @validation.validate_local("abc.!#$%&'*+-/=?^_`{|}~")
    assert_equal false, @validation.validate_local(".hoge")
    assert_equal false, @validation.validate_local("hoge.")
    assert_equal false, @validation.validate_local("hoge..fuga")
    assert_equal false, @validation.validate_local('hoge"')
    assert_equal false, @validation.validate_local('"hoge')
    text = <<~EOF.chomp
      \"!#$%&'*+-/=?^_`{|}~(),.:;<>@[]\"\\\"
    EOF
    assert_equal true, @validation.validate_local(text)
    assert_equal true, @validation.validate_local('""')
    assert_equal false, @validation.validate_local('"')
  end

  def test_domain
    assert_equal true, @validation.validate_domain("example.com\n")
    assert_equal true, @validation.validate_domain("hoge.!#$%&'*+-/=?^_`{|}~.com\n")
    assert_equal false, @validation.validate_domain(".example.com")
    assert_equal false, @validation.validate_domain("com.")
    assert_equal false, @validation.validate_domain("example..com")
    assert_equal false, @validation.validate_domain("")
    assert_equal true, @validation.validate_domain("d")
  end

end
