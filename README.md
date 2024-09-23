# README

This project shows how you can implement Impersonation aka "Login as x user" feature with Rails as an API.

You can view all changes required to implement Impersonation in the PR [Impersonate User](https://github.com/coolprobn/impersonate-user-rails-api/pull/1/files)

I have made use of [pretender gem](https://github.com/ankane/pretender) and extended it's functionality for this implementation.

## Tested and working in

- Ruby 3.3.0
- Rails 7.2.1
- Devise 4.9.4 & Devise JWT 0.11.0
- Pretender 0.5.0

## Installation

1. Clone the repo locally:

    ```bash
    git clone git@github.com:coolprobn/impersonate-user-rails-api.git
    cd impersonate-user-rails-api
    git checkout impersonate-user
    ```

2. Setup the application with gems and database records

    ```bash
    bin/setup
    ```

    This will setup the database and also create records from the `db/seed.rb` file required to get you up and running with the project so you can test out the feature with ease.

3. Start the application

    ```bash
    bin/rails s
    ```

API will be running at `http://localhost:3000` and you can use [Postman](https://www.postman.com/) or any other API client to test out the API

## Some important APIs

Please note that IDs I am using to make API calls might vary with your app, just check the database and update it to what you have if that happens.

And all of the requests we make with the API will require Authorization header with the token apart from the Login API so make sure to check you are passing Bearer token to the request if you get Unauthorized or Forbidden errors from the API.

### Login

Send POST request to `http://localhost:3000/login` with the following form body:

```json
{
  "user": {
    "email": "john@email.com",
    "password": "john@1234"
  }
}
```

This will log you in as an user with the admin role which is required for impersonating other users. If you are curious, you can refer to the seed file to see what other users and other records have been created in the database.

You should receive "authorization" header back when login is successful which includes the Bearer token similar to `Bearer eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiI ... ... ....`. You should use that token to authenticate the user going forward so save that token somewhere to reuse later.

### Impersonate User

Send POST request to `http://localhost:3000/users/3/impersonate` and set the "Authorization" header for the request with the token you had got while logging in.

You will receive a response like the following on success:

```json
{
  "impersonating_user_id": 3,
  "email": "john@email.com",
  "id": 1,
  "created_at": "2024-03-16T12:19:24.927Z",
  "updated_at": "2024-09-23T16:05:05.438Z",
  "name": "John",
  "role": "admin",
  "jti": "07000081-3be0-4280-bdde-7672e1ba4475"
}
```

### Stop Impersonation

Send POST request to `http://localhost:3000/users/stop_impersonating` to stop the impersonation for the current impersonated user i.e. user with ID 3 in the example.

**impersonating_user_id** will come back null if API succeeds indicating logged in user is not impersonating anyone anymore.

### Logout

Send DELETE request to `http://localhost:3000/logout` for logging out the current user. Don't forget to send the Authorization header with token while doing so.

## Test impersonation feature

To test out if the impersonation feature is working correctly, you can do the following:

- Login as user with audience role
- Try to access Movie Reviews of a different user and get Forbidden error
- Login with user with admin role
- Impersonate the user for whom you were getting Forbidden error when accessing movie reviews
- Access Movie Reviews of the same user for which you had got Forbidden error before. API should respond with success status if impersonation is working correctly.

### Login as user with audience role

Send POST request to `http://localhost:3000/login` with the following form body:

```json
{
  "user": {
    "email": "mara@email.com",
    "password": "mara@1234"
  }
}
```

### Update a movie review of the user "Pascal"

Send PATCH request to `http://localhost:3000/movie_user_reviews/2` with the following body:

```json
{
  "movie_user_review": {
    "rating": 10.0,
    "review": "Titanic is a very good movie. Must watch for everyone!"
  }
}
```

You will get Forbidden error from the API.

### Login as an admin user

Send POST request to `http://localhost:3000/login` with the following form body:

```json
{
  "user": {
    "email": "john@email.com",
    "password": "john@1234"
  }
}
```

Note: Don't forget to copy Bearer token and update it in upcoming requests.

### Impersonate the user "Pascal"

Send POST request to `http://localhost:3000/users/3/impersonate`. You should receive a response back with Pascal's user id inside the attribute **impersonating_user_id**

### Update a movie review of the user "Pascal" while impersonation is active

Send PATCH request to `http://localhost:3000/movie_user_reviews/2` with the following body:

```json
{
  "movie_user_review": {
    "rating": 10.0,
    "review": "Titanic is a very good movie. Must watch for everyone!"
  }
}
```

You should get success response with the updated detail for the movie review now. And this also indicates impersonation feature is working correctly.

## Issues

If you run into any issues while running or implementing the Impersonation user while following this project, you can create a [new issue](https://github.com/coolprobn/impersonate-user-rails-api/issues) or just send me a DM on [Twitter](https://twitter.com/coolprobn) and I will try to help you out.

## References

- [Rails 7: API-only app with Devise and JWT for authentication](https://sdrmike.medium.com/rails-7-api-only-app-with-devise-and-jwt-for-authentication-1397211fb97c)
- [Comment in Pretender Gem Issue#59 - Use Pretender methods with JWT tokens instead of session](https://github.com/ankane/pretender/issues/59#issuecomment-1475278897)
