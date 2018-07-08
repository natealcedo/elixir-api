defmodule MyAppWeb.AuthenticationController do
  use MyAppWeb, :controller

  alias MyApp.Auth

  plug(Ueberauth)

  def identity_callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    IO.inspect(auth)
    email = auth.uid
    password = auth.credentials.other.password
    handle_user_conn(Auth.authenticate_user(email, password), conn)
  end

  defp handle_user_conn(user, conn) do
    case user do
      {:ok, user} ->
        {:ok, jwt, _full_claims} = Auth.Guardian.encode_and_sign(user, %{})

        conn
        |> put_resp_header("authorization", "Bearer #{jwt}")
        |> json(%{token: jwt})

      {:error, _reason} ->
        conn
        |> put_status(401)
        |> json(%{message: "user not found"})
    end
  end
end
