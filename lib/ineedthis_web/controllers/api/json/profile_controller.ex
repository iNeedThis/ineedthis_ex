defmodule IneedthisWeb.Api.Json.ProfileController do
  use IneedthisWeb, :controller

  alias Ineedthis.Users.User
  alias Ineedthis.Repo
  import Ecto.Query

  def show(conn, %{"id" => id}) do
    user =
      User
      |> where(id: ^id)
      |> preload(public_links: :tag, awards: :badge)
      |> Repo.one()

    cond do
      is_nil(user) or user.deleted_at ->
        conn
        |> put_status(:not_found)
        |> text("")

      true ->
        render(conn, "show.json", user: user)
    end
  end
end
