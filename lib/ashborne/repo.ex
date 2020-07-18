defmodule Ashborne.Repo do
  use Ecto.Repo,
    otp_app: :ashborne,
    adapter: Ecto.Adapters.Postgres
end
