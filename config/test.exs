use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :chatter, ChatterWeb.Endpoint,
  http: [port: 4002],
  server: true

config :chatter, :sql_sandbox, true

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :chatter, Chatter.Repo,
  username: "postgres",
  password: "postgres",
  database: "chatter_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
