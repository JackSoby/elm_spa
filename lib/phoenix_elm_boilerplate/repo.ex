defmodule PhoenixElmBoilerplate.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_elm_boilerplate,
    adapter: Ecto.Adapters.Postgres
end
