import Config

# Configure your database
config :ineedthis, Ineedthis.Repo,
  hostname: "postgres",
  username: "postgres",
  password: "postgres",
  database: "ineedthis_test",
  pool: Ecto.Adapters.SQL.Sandbox

config :ineedthis,
  pwned_passwords: false,
  captcha: false

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ineedthis, IneedthisWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
