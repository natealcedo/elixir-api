defmodule MyAppWeb.Plug.AuthAccessPipeline do
  use Guardian.Plug.Pipeline, otp_app: :my_app

  plug(Guardian.Plug.VerifyHeader)
  plug(Guardian.Plug.EnsureAuthenticated)
  plug(Guardian.Plug.LoadResource, ensure: true)
end
