require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def json_response
      ActiveSupport::JSON.decode @response.body
  end

  def test_index
    FactoryBot.create(:user, id: 1001)
    FactoryBot.create(:user, id: 1002)

    get :index

    assert_response :success

    assert_equal 1001, json_response.first["id"]
    assert_equal 1002, json_response.second["id"]
  end

  def test_show
    user = FactoryBot.create(:user, id: 1001)

    get :show, params: {id: 1001}

    assert_response :success

    assert_equal 1001, json_response["id"]
  end

  def test_create
    assert_difference "User.count", 1 do
      post(
        :create,
        params: {
          user: {
            name: "TEST_USER",
            email: "email@test.com",
            phone_number: "000",
            properties: {
              "shoe_size": "42"
            }
          }
        }
      )
    end

    user = User.last

    assert_response :success
    assert_equal user.id, json_response["user"]["id"]
    assert_equal "TEST_USER", user.name
    assert_equal "email@test.com", user.email
    assert_equal "000", user.phone_number
    assert_equal({"shoe_size" => "42"}, user.properties)
  end

  def test_create_not_valid
    assert_difference "User.count", 0 do
      post(
        :create,
        params: {
          user: {
            name: "TEST_USER",
            email: "WRONG_EMAIL",
            phone_number: "000",
            properties: {
              "shoe_size": "42"
            }
          }
        }
      )
    end

    assert_equal({"errors"=>{"email"=>["is invalid"]}, "status"=>"unprocessable_entity"}, json_response)
  end

  def test_update
    user = FactoryBot.create(:user)
    put(
      :update,
      params: {
        id: user.id,
        user: {
          name: "UPDATED_NAME",
          properties: {
            "shoe_size": "42",
          }
        }
      }
    )

    user = User.last

    assert_response :success
    assert_equal user.id, json_response["user"]["id"]
    assert_equal "UPDATED_NAME", user.name
    assert_equal({"shoe_size" => "42"}, user.properties)
  end

  def test_update_invalid
    user = FactoryBot.create(:user)
    put(
      :update,
      params: {
        id: user.id,
        user: {
          email: "WRONG_EMAIL",
        }
      }
    )

    user = User.last
    refute_equal "WRONG_EMAIL", user.email
    assert_response :unprocessable_entity
    assert_equal({"errors"=>{"email"=>["is invalid"]}, "status"=>"unprocessable_entity"}, json_response)
  end

  def test_destroy
    user = FactoryBot.create(:user)
    assert_difference "User.count", -1 do
      delete(
        :destroy,
        params: {
          id: user.id
        }
      )

      assert_response :success
      assert_equal({ "status" => "no_content" }, json_response)
    end
  end
end
