
require 'test_helper'

class PropertiesManagerTest < ActiveSupport::TestCase
  def test_properties
    user = FactoryBot.create(:user)

    user.properties = {test_key_1: "test_value_1", test_key_2: "test_value_2"}

    user_properties = user.user_properties

    assert_equal "test_key_1", user_properties.first.name
    assert_equal "test_value_1", user_properties.first.value
    assert_equal "test_key_2", user_properties.second.name
    assert_equal "test_value_2", user_properties.second.value
    assert_equal({"test_key_1" => "test_value_1", "test_key_2" => "test_value_2"}, user.properties)
  end

  def test_get_property
    user = FactoryBot.create(:user)
    user.properties = {test_key_1: "test_value_1", test_key_2: "test_value_2"}

    assert_equal "test_value_1", user.get_property("test_key_1")
    assert_equal "test_value_2", user.get_property("test_key_2")
    assert_nil user.get_property("test_key_3")
  end

  def test_set_property
    user = FactoryBot.create(:user, properties: {"test_key_1" => "test_value_1"})
    user.set_property("test_key_1", "test_value_2")
    user.set_property("test_key_2", "test_value_2")

    assert_equal({"test_key_1" => "test_value_2", "test_key_2" => "test_value_2"}, user.properties)
  end

  def test_as_json
    user = FactoryBot.create(:user, name: "USER_NAME", email: "test@email.com", phone_number: "000")
    user.properties = {test_key_1: "test_value_1", test_key_2: "test_value_2"}

    expected_hash = {
      "id"=>user.id,
      "name"=>"USER_NAME",
      "phone_number"=>"000",
      "email"=>"test@email.com",
      "properties"=>{"test_key_1"=>"test_value_1", "test_key_2"=>"test_value_2"}
    }

    assert_equal(expected_hash, user.as_json.except("created_at", "updated_at"))
  end
end
