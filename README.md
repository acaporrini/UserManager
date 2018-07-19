# User Manager
### A Rails demo application to manage users with custom attributes.

The user model has fixed attributes (name, email, phone number) but can also store custom data through the 'properties' attribute.
To achieve that I used an additional model "UserProperty" which will store the key and value of of each property with a reference to the User model.
I used a PropertiesManager concern in app/models/concerns/users/properties_manager.rb to handle all the logic related to the 'properties': getter, setter and json rendering.
In this way the user model and table are completley indipendent from the custom properties logic.

The properties can be queried through the foreign key which link every property to a specific user, for example:

```sql
SELECT "user_properties".* FROM "user_properties" WHERE "user_properties"."user_id" = 9;
SELECT  "user_properties".* FROM "user_properties" WHERE "user_properties"."user_id" = 9 AND "user_properties"."name" = "size";
```

The project expose a JSON api to create, read, update and destroy a user.
# Install and run
- Clone repository
- ``` bundle install ```
- ``` bundle exec rake db:create ```
- ``` bundle exec rake db:migrate ```
- ``` rails s ```

# API endpoints

### Index

```
GET /users/ HTTP/1.1
Host: localhost:3000
Content-Type: application/json

# Response

[
    {
        "id": 1,
        "name": "test_name_01",
        "phone_number": "001-001",
        "email": "test@gmail.com",
        "created_at": "2018-07-19T16:39:01.419Z",
        "updated_at": "2018-07-19T16:43:52.129Z",
        "properties": {
            "size": "s",
            "price": "300"
        }
    },
    {
        "id": 2,
        "name": "test_name_02",
        "phone_number": "000",
        "email": "test2@email.com",
        "created_at": "2018-07-19T16:40:12.167Z",
        "updated_at": "2018-07-19T16:40:12.167Z",
        "properties": {}
    }
]
```
### Show
```
GET /users/8 HTTP/1.1
Host: localhost:3000
Content-Type: application/json

# Response

{
    "id": 8,
    "name": "test_name",
    "phone_number": "000",
    "email": "test2@email.com",
    "created_at": "2018-07-19T19:48:31.123Z",
    "updated_at": "2018-07-19T19:48:57.833Z",
    "properties": {
        "size": "m"
    }
}

```
### Create
```
POST /users HTTP/1.1
Host: localhost:3000
Content-Type: application/json

{"email": "test@gmail.com", "name": "test_name", "phone_number": "000", "properties": {"size": "m" } }

# Response

{
    "status": "ok",
    "user": {
        "id": 7,
        "name": "test_name",
        "phone_number": "000",
        "email": "test@gmail.com",
        "created_at": "2018-07-19T17:08:49.672Z",
        "updated_at": "2018-07-19T17:08:49.672Z",
        "properties": {
            "size": "m"
        }
    }
}
```
### Update

```
PUT /users/8 HTTP/1.1
Host: localhost:3000
Content-Type: application/json


{"email": "test2@email.com" }

# Response

{
    "status": "ok",
    "user": {
        "id": 8,
        "email": "test2@email.com",
        "name": "test_name",
        "phone_number": "000",
        "created_at": "2018-07-19T19:48:31.123Z",
        "updated_at": "2018-07-19T19:48:57.833Z",
        "properties": {
            "size": "m"
        }
    }
}
```

### Destroy

```
DELETE /users/8 HTTP/1.1
Host: localhost:3000
Content-Type: application/json
Cache-Control: no-cache
Postman-Token: 4efb0828-718f-d005-5d3f-3f71af9c835f


# Response

{
    "status": "no_content"
}
```


# Usage

```ruby
user = User.create(name: "username", email:"test@email.com", phone_number: "000")
# => #<User id: 9, name: "username", phone_number: "000", email: "test@email.com", created_at: "2018-07-19 19:53:21", updated_at: "2018-07-19 19:53:21", properties: nil>

user.set_property("size", "m")
user.get_property("size")
# => "m"

user.properties
# => {"size"=>"m"}

user.properties = {"nickname" => "Cool User"}
user.properties
# => {"size"=>"m", "nickname"=>"Cool User"}
```

# Run Test

```ruby
bundle exec rake test
```

## Test files
- test/controllers/users_controller_test.rb
- test/models/user_property_test.rb
- test/models/users_test.rb
- test/models/concerns/users/property_manager_test.rb
