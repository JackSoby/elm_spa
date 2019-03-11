defmodule ElmSpa.Repo do
  use Ecto.Repo,
    otp_app: :elm_spa,
    adapter: Ecto.Adapters.Postgres
end
