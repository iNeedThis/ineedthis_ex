defmodule IneedthisWeb.Api.Json.Filter.SystemFilterController do
  use IneedthisWeb, :controller

  alias Ineedthis.Filters.Filter
  alias Ineedthis.Repo
  import Ecto.Query

  def index(conn, _params) do
    system_filters =
      Filter
      |> where(system: true)
      |> order_by(asc: :id)
      |> Repo.paginate(conn.assigns.scrivener)

    conn
    |> put_view(IneedthisWeb.Api.Json.FilterView)
    |> render("index.json", filters: system_filters, total: system_filters.total_entries)
  end
end
