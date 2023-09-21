[![Contributors](https://img.shields.io/github/contributors/sicknacco/lend-a-toolza-be.svg)](https://github.com/javenb022/tea_subscription/graphs/contributors)
[![Forks](https://img.shields.io/github/forks/sicknacco/lend-a-toolza-be.svg)](https://github.com/javenb022/tea_subscription/forks)
[![Stargazers](https://img.shields.io/github/stars/sicknacco/lend-a-toolza-be.svg)](https://github.com/javenb022/tea_subscription/stargazers)
[![Issues](https://img.shields.io/github/issues/sicknacco/lend-a-toolza-be.svg)](https://github.com/javenb022/tea_subscription/issues)

# Tea Subscription



## About This Project
### Important to Note!!!
You do not need an API key to have access to all endpoints.

### Use of API
The purpose of this API is to keep track of subscriptions to the many different flavors and variants of teas available. This API offers other functionality such as:
  - Subscribe to a tea
  - Unsubscribe from a tea
  - Get all subscriptions for a user

## Built With
* ![Ruby](https://img.shields.io/badge/ruby-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white)
* ![Rails](https://img.shields.io/badge/rails-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
* ![Postgresql](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
* ![Visual Studio Code](https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white)
* ![Postman Badge](https://img.shields.io/badge/Postman-FF6C37?logo=postman&logoColor=fff&style=for-the-badge)

## Running On
  - Rails 7.0.6
  - Ruby 3.2.2

## <b>Getting Started</b>

To get a local copy, follow these simple instructions

### <b>Installation</b>

1. Fork the Project
2. Clone the repo
```
git clone git@github.com:javenb022/tea_subscription.git
```
3. Install the gems
```
bundle install
```
4. Create the database
```
rails db:{create,migrate,seed}
```
8. Create your Feature Branch
```
git checkout -b feature/AmazingFeature
```
9. Commit your Changes
```
git commit -m 'Add some AmazingFeature'
```
10. Push to the Branch
```
git push origin feature/AmazingFeature
```
11. Open a Pull Request

## Endpoints Used

<div style="overflow: auto; height: 200px;">
  <pre>
    <code>
      get "/api/v1/users/:user_id/subscriptions", to: "api/v1/subscription#index"
      - Gets all the subscriptions for a User
      post "/api/v1/users/:id/subscribe", to: "api/v1/subscription#create"
      - Allows a user to subscribe to a tea
      patch "/api/v1/users/:id/unsubscribe", to: "api/v1/unsubscribe#update"
      - Allows a user to unsubscribe from a tea
    </code>
  </pre>
</div>



## Schema
```
  create_table "subscriptions", force: :cascade do |t|
    t.string "title"
    t.string "status", default: "Inactive"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "frequency"
    t.bigint "tea_id"
    t.index ["tea_id"], name: "index_subscriptions_on_tea_id"
  end

  create_table "teas", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "temperature"
    t.string "brew_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_subscriptions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "subscription_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subscription_id"], name: "index_user_subscriptions_on_subscription_id"
    t.index ["user_id"], name: "index_user_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "subscriptions", "teas"
  add_foreign_key "user_subscriptions", "subscriptions"
  add_foreign_key "user_subscriptions", "users"
```
## Payload
### The payload for a request should include all of these attributes for each endpoint
```
# Subscribe
payload = {
          "email": "user@email.com",
          "first_name": "Bob",
          "last_name": "Jones",
          "address": "123 Main St",
          "tea_id": 1,
          "title": "Pro",
          "price": 10.00,
          "frequency": "Monthly",
          "status": "Active"
        }
```
```
# Unsubscribe
payload =
      {
        "sub_id": 1,
        "status": "Inactive"
      }
```

## Responses
### What they should look like:
```
# User Unsubscribes
{:data=>
  {:id=>"42",
  :type=>"subscription",
  :attributes=>
    {:title=>"Pro",
    :price=>10.0,
    :frequency=>"Monthly",
    :status=>"Inactive"}}}
```
```
# User Subscribes
{:data=>
  {:id=>2,
   :type=>"subscription",
   :attributes=>{:title=>"Adict", :price=>15.0, :frequency=>"Monthly", :status=>"Active"},
   :tea_info=>{:tea_id=>5, :tea_title=>"Green Tea", :tea_description=>"Tea", :tea_temperature=>"200", :tea_brew_time=>"5"}}}
```
```
# Get All Subscriptions for a User
[{:data=>
   {:id=>1,
    :type=>"subscription",
    :attributes=>{:title=>"Pro", :price=>10.0, :frequency=>"Monthly", :status=>"Active"},
    :tea_info=>{:tea_id=>4, :tea_title=>"Earl Grey", :tea_description=>"Tea", :tea_temperature=>"200", :tea_brew_time=>"5"}}},
 {:data=>
   {:id=>2,
    :type=>"subscription",
    :attributes=>{:title=>"Adict", :price=>15.0, :frequency=>"Monthly", :status=>"Active"},
    :tea_info=>{:tea_id=>5, :tea_title=>"Green Tea", :tea_description=>"Tea", :tea_temperature=>"200", :tea_brew_time=>"5"}}}]
```

## Contributing  [![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/javenb022/tea_subscription)
Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

## Authors
- Javen Wilson [![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white) ](https://github.com/javenb022) [![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white) ](https://www.linkedin.com/in/javen-wilson/)

## Planning Tools
- [![Miro Board](https://img.shields.io/badge/Miro-050038?style=for-the-badge&logo=Miro&logoColor=white)](https://miro.com/app/board/uXjVMkc6QEM=/?share_link_id=565700474557)
- ![DBDiagram](https://img.shields.io/badge/DBDiagram-1167b1)