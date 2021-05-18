defmodule IneedthisWeb.Api.Json.Search.GalleryController do
  use IneedthisWeb, :controller

  alias Ineedthis.Elasticsearch
  alias Ineedthis.Galleries.Gallery
  alias Ineedthis.Galleries.Query
  import Ecto.Query

  def index(conn, params) do
    case Query.compile(params["q"] || "") do
      {:ok, query} ->
        galleries =
          Gallery
          |> Elasticsearch.search_definition(
            %{
              query: query,
              sort: %{created_at: :desc}
            },
            conn.assigns.pagination
          )
          |> Elasticsearch.search_records(preload(Gallery, [:creator]))

        conn
        |> put_view(IneedthisWeb.Api.Json.GalleryView)
        |> render("index.json", galleries: galleries, total: galleries.total_entries)

      {:error, msg} ->
        conn
        |> put_status(:bad_request)
        |> json(%{error: msg})
    end
  end
end
