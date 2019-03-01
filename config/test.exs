use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :phoenix_elm_boilerplate, PhoenixElmBoilerplateWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :phoenix_elm_boilerplate, PhoenixElmBoilerplate.Repo,
  username: "postgres",
  password: "postgres",
  database: "phoenix_elm_boilerplate_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
