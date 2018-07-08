use Mix.Config

config :my_app, ecto_repos: [MyApp.Repo]

config :my_app, MyAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "sbv/WfeKpUkobdU3ORyzyiGBFLYFFyHUmYG7bSodcm4bb9tNTLhqvueyD48JAfkw",
  render_errors: [view: MyAppWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: MyApp.PubSub, adapter: Phoenix.PubSub.PG2]

config :my_app, MyApp.Auth.Guardian,
  issuer: "Auth",
  secret_key: "V77QGL4n8s3vFpwSe0KF32Mxh4frd7GHpF+c/qRtoJZdz4BRzr+/pj5eWfh+RscE"

config :my_app, MyAppWeb.Plug.AuthAccessPipeline,
  module: MyApp.Auth.Guardian,
  error_handler: MyAppWeb.Plug.AuthErrorHandler

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :ueberauth, Ueberauth,
  base_path: "/api/auth",
  providers: [
    identity:
      {Ueberauth.Strategy.Identity,
       [
         callback_methods: ["POST"],
         nickname_field: :email,
         uid_field: :email
       ]}
  ]

import_config("#{Mix.env()}.exs")
