
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_validate_email
    user = FactoryBot.build(:user, email: nil)

    refute user.valid?
    assert_equal [:email], user.errors.keys

    user.email = "WRONG_FORMAT"
    refute user.valid?
    assert_equal [:email], user.errors.keys

    user.email = "test@mail.com"
    assert user.valid?
  end

  def test_validate_name
    user = FactoryBot.build(:user, name: nil)

    refute user.valid?
    assert_equal [:name], user.errors.keys

    user.name = "USER_NAME"
    assert user.valid?
  end

  def test_validate_phone_number
    user = FactoryBot.build(:user, phone_number: nil)

    refute user.valid?
    assert_equal [:phone_number], user.errors.keys

    user.phone_number = "PHONE_NUMBER"
    assert user.valid?
  end
end
