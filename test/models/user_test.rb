require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user=User.new(:name => "raj", email: "raj@gmail.com", password: "rajeevr",
      password_confirmation: "rajeevr")
  end

  test "check validiy" do
    assert @user.valid?
  end

  test "name shouldbe present" do
    @user.name=""
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email=""
    assert_not @user.valid?
  end

  test "name length in limit" do
    @user.name="a"*51
    assert_not @user.valid?
  end

  test "email length in limit" do
    @user.email="a"*250 +"email.com"
    assert_not @user.valid?
  end

  test "valid email" do
    valid_addresses=%w[sam@email.com USER@foo.COM A_US-ER@foo.bar.org
first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email=valid_address
      assert @user.valid? , "#{valid_address.inspect} should be valid"
    end
  end

  test "invalid email" do
    invalid_addresses=%w[user@example,com user_at_foo.org user.name@example.
foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email=invalid_address
      assert_not @user.valid? , "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email address should be unique" do
    user_dup=@user.dup
    @user.save
    user_dup.email=@user.email.upcase
    assert_not user_dup.valid?
  end

  test "password length minimum required" do
    @user.password=@user.password_confirmation="a"*5
    assert_not @user.valid?
  end

  test "authenticated? returns false when remember digest nil" do
    assert_not @user.authenticated?(:remember,'')
  end

end
