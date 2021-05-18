defmodule IneedthisWeb.Api.Json.Search.FilterController do
  use IneedthisWeb, :controller

  alias Ineedthis.Elasticsearch
  alias Ineedthis.Filters.Filter
  alias Ineedthis.Filters.Query
  import Ecto.Query

  def index(conn, params) do
    user = conn.assigns.current_user

    case Query.compile(user, params["q"] || "") do
      {:ok, query} ->
        filters =
          Filter
          |> Elasticsearch.search_definition(
            %{
              query: %{
                bool: %{
                  must: [
                    query,
                    %{
                      bool: %{
                        should:
                          [%{term: %{public: true}}, %{term: %{system: true}}] ++
                            user_should(user)
                      }
                    }
                  ]
                }
              },
              sort: [
                %{name: :asc},
                %{id: :desc}
              ]
            },
            conn.assigns.pagination
          )
          |> Elasticsearch.search_records(preload(Filter, [:user]))

        conn
        |> put_view(IneedthisWeb.Api.Json.FilterView)
        |> render("index.json", filters: filters, total: filters.total_entries)

      {:error, msg} ->
        conn
        |> put_status(:bad_request)
        |> json(%{error: msg})
    end
  end

  defp user_should(user) do
    case user do
      nil ->
        []

      user ->
        [%{term: %{user_id: user.id}}]
    end
  end
end
