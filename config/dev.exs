use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :elixirer, Elixirer.Endpoint,
  http: [port: 5000],
  debug_errors: false,
  code_reloader: true,
  check_origin: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch", "--stdin", cd: Path.expand("../", __DIR__)]]

# Watch static and templates for browser reloading.
config :elixirer, Elixirer.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development.
# Do not configure such in production as keeping
# and calculating stacktraces is usually expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :elixirer, Elixirer.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "elixirer_dev",
  hostname: "localhost",
  pool_size: 10


config :qiniu, Qiniu,
  access_key: "-H3ZcpN0XxKjaNKKdyI-l1LW0i69tdJXbKA0Zmo-",
  secret_key: "I8MMFZrYAnJNmIxLAI3obLgHzO9fyOydNnR7F0Ep",
  cdn_host: "http://o6tiaeexk.bkt.clouddn.com"

config :tirexs, :uri, "http://127.0.0.1:9200"