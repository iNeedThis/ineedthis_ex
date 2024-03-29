defmodule IneedthisWeb.Admin.Badge.UserController do
  use IneedthisWeb, :controller

  alias Ineedthis.Users.User
  alias Ineedthis.Badges.Badge
  alias Ineedthis.Repo
  import Ecto.Query

  plug :verify_authorized
  plug :load_resource, model: Badge, id_name: "badge_id", persisted: true

  def index(conn, _params) do
    badge = conn.assigns.badge

    users =
      User
      |> join(:inner, [u], _ in assoc(u, :awards))
      |> where([_u, a], a.badge_id == ^badge.id)
      |> order_by([u, _a], asc: u.name)
      |> Repo.paginate(conn.assigns.scrivener)

    render(conn, "index.html", title: "Users with badge #{badge.title}", users: users)
  end

  defp verify_authorized(conn, _opts) do
    case Canada.Can.can?(conn.assigns.current_user, :index, Badge) do
      true -> conn
      _false -> IneedthisWeb.NotAuthorizedPlug.call(conn)
    end
  end
end
