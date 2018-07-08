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

  pipeline :authenticated do
    plug(MyAppWeb.Plug.AuthAccessPipeline)
  end

  scope "/api", MyAppWeb do
    pipe_through(:api)

    scope "/auth" do
      post("/identity/callback", AuthenticationController, :identity_callback)
    end

    scope "/" do
      resources("/users", UserController, only: [:create])

      pipe_through(:authenticated)
      resources("/users", UserController, except: [:new, :edit])
    end
  end
end
