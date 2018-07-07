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

  pipeline :auth do
    plug(:ensure_authenticated)
  end

  scope "/api", MyAppWeb do
    pipe_through(:api)
    post("/users/sign_in", UserController, :sign_in)
    resources("/users", UserController, only: [:create])
  end

  scope "/api", MyAppWeb do
    pipe_through([:api, :auth])

    resources("/users", UserController, except: [:new, :edit])
  end

  defp ensure_authenticated(conn, _opts) do
    user_id = get_session(conn, :user_id)

    if user_id do
      conn
    else
      conn
      |> put_status(403)
      |> render(MyAppWeb.ErrorView, "401.json", message: "Unauthenticated user")
      |> halt()
    end
  end
end
