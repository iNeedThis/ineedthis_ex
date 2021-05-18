defmodule Ineedthis.Repo do
  use Ecto.Repo,
    otp_app: :ineedthis,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 250
end
