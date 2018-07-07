defmodule MyAppWeb.Router do
  use MyAppWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
    plug(:fetch_session)

    plug(
      Corsica,
      origins: "http://localhost:8080",
      log: [rejected: :error, invalid: :warn, accepted: :debug],
      allow_headers: ["content-type"],
      allow_credentials: true
    )
  end

  scope "/api", MyAppWeb do
    pipe_through(:api)

    resources("/users", UserController, except: [:new, :edit])
    post("/users/sign_in", UserController, :sign_in)
  end
end
