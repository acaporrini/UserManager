
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_validate_user_reference
    user_property = FactoryBot.build(:user_property, user: nil)

    refute user_property.valid?
    assert_equal [:user], user_property.errors.keys

    user_property.user = FactoryBot.create(:user)
    assert user_property.valid?
  end

  def test_validate_name
    user_property = FactoryBot.build(:user_property, name: nil)

    refute user_property.valid?
    assert_equal [:name], user_property.errors.keys

    user_property.name = "NAME"
    assert user_property.valid?
  end

  def test_validate_value
    user_property = FactoryBot.build(:user_property, value: nil)

    refute user_property.valid?
    assert_equal [:value], user_property.errors.keys

    user_property.value = "VALUE"
    assert user_property.valid?
  end
end
