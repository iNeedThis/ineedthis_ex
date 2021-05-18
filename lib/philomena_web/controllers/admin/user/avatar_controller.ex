defmodule IneedthisWeb.Admin.User.AvatarController do
  use IneedthisWeb, :controller

  alias Ineedthis.Users.User
  alias Ineedthis.Users

  plug :verify_authorized
  plug :load_resource, model: User, id_name: "user_id", id_field: "slug", persisted: true

  def delete(conn, _params) do
    {:ok, _user} = Users.remove_avatar(conn.assigns.user)

    conn
    |> put_flash(:info, "Successfully removed avatar.")
    |> redirect(to: Routes.admin_user_path(conn, :edit, conn.assigns.user))
  end

  defp verify_authorized(conn, _opts) do
    case Canada.Can.can?(conn.assigns.current_user, :index, User) do
      true -> conn
      _false -> IneedthisWeb.NotAuthorizedPlug.call(conn)
    end
  end
end
