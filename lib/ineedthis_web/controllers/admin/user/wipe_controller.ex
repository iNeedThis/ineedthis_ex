defmodule IneedthisWeb.Admin.User.WipeController do
  use IneedthisWeb, :controller

  alias Ineedthis.UserWipeWorker
  alias Ineedthis.Users.User

  plug :verify_authorized
  plug :load_resource, model: User, id_name: "user_id", id_field: "slug", persisted: true

  def create(conn, _params) do
    Exq.enqueue(Exq, "indexing", UserWipeWorker, [conn.assigns.user.id])

    conn
    |> put_flash(
      :info,
      "PII wipe queued, please verify and then deactivate the account as necessary."
    )
    |> redirect(to: Routes.profile_path(conn, :show, conn.assigns.user))
  end

  defp verify_authorized(conn, _opts) do
    case Canada.Can.can?(conn.assigns.current_user, :index, User) do
      true -> conn
      _false -> IneedthisWeb.NotAuthorizedPlug.call(conn)
    end
  end
end
