# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :pento,
  ecto_repos: [Pento.Repo]

config :pento, Pento.Repo, migration_primary_key: [name: :id, type: :uuid]

# Configures the endpoint
config :pento, PentoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "X7bUx2l4F5pgqgUVxOLLd34z6zT4qOseSxMlhKka9sd5o3pUzitv83BqWsxlZRFY",
  render_errors: [view: PentoWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Pento.PubSub,
  live_view: [signing_salt: "4cAQULI7"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
