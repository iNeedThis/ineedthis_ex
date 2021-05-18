# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :logger,
  compile_time_purge_matching: [
    [application: :remote_ip],
    [application: :mint]
  ]

config :ineedthis,
  ecto_repos: [Ineedthis.Repo]

config :elastix,
  json_codec: Jason

config :exq,
  max_retries: 5,
  scheduler_enable: true,
  start_on_application: false

config :canary,
  repo: Ineedthis.Repo,
  unauthorized_handler: {IneedthisWeb.NotAuthorizedPlug, :call},
  not_found_handler: {IneedthisWeb.NotFoundPlug, :call}

# Configures the endpoint
config :ineedthis, IneedthisWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "xZYTon09JNRrj8snd7KL31wya4x71jmo5aaSSRmw1dGjWLRmEwWMTccwxgsGFGjM",
  render_errors: [view: IneedthisWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: Ineedthis.PubSub,
  live_view: [signing_salt: "bxvRXvPOSbl6/z/Dt4s2X2/9MO7kArZv"]

config :phoenix, :template_engines,
  slim: PhoenixSlime.Engine,
  slime: PhoenixSlime.Engine,
  slimleex: PhoenixSlime.LiveViewEngine

config :tesla, adapter: Tesla.Adapter.Mint

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  handle_otp_reports: true,
  handle_sasl_reports: true,
  metadata: [:request_id],
  truncate: :infinity

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason
config :bamboo, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
