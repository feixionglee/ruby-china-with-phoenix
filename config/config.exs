# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :elixirer, Elixirer.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "wkYQ38kB17M/VMywpWsRnQBaJu1f3k1lfyPcv+O04YFzRtS3CwCzGcsS5a3mUOFA",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Elixirer.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

config :elixirer, ecto_repos: [Elixirer.Repo]

config :scrivener_html,
  routes_helper: Elixirer.Router.Helpers

config :alchemic_avatar,
  cache_base_path: "static",             # default is "static"
  colors_palette: :iwanthue,             # default is :google
  weight: 200,                           # default is 300
  annotate_position: "-0+10",             # default is -0+5
  app_name: :elixirer #your app name(required)