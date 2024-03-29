defmodule Ineedthis.Schema.Search do
  alias Ineedthis.Images.Query
  alias Ineedthis.Search.String
  import Ecto.Changeset

  def validate_search(changeset, field, user, watched \\ false) do
    query = changeset |> get_field(field) |> String.normalize()
    output = Query.compile(user, query, watched)

    case output do
      {:ok, _} ->
        changeset

      _ ->
        add_error(changeset, field, "is invalid")
    end
  end
end
