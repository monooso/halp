defmodule Halp.Repo do
  use Ecto.Repo,
    otp_app: :halp,
    adapter: Ecto.Adapters.Postgres
end
