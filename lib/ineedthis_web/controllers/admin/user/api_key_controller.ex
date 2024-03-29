defmodule IneedthisWeb.Admin.User.ApiKeyController do
  use IneedthisWeb, :controller

  alias Ineedthis.Users.User
  alias Ineedthis.Users

  plug :verify_authorized
  plug :load_resource, model: User, id_name: "user_id", id_field: "slug", persisted: true

  def delete(conn, _params) do
    {:ok, user} = Users.reset_api_key(conn.assigns.user)

    conn
    |> put_flash(:info, "API token successfully reset.")
    |> redirect(to: Routes.profile_path(conn, :show, user))
  end

  defp verify_authorized(conn, _opts) do
    case Canada.Can.can?(conn.assigns.current_user, :index, User) do
      true -> conn
      _false -> IneedthisWeb.NotAuthorizedPlug.call(conn)
    end
  end
end
