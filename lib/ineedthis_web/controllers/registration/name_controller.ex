defmodule IneedthisWeb.Registration.NameController do
  use IneedthisWeb, :controller

  alias Ineedthis.Users

  plug IneedthisWeb.FilterBannedUsersPlug
  plug :verify_authorized

  def edit(conn, _params) do
    changeset = Users.change_user(conn.assigns.current_user)

    render(conn, "edit.html", title: "Editing Name", changeset: changeset)
  end

  def update(conn, %{"user" => user_params}) do
    case Users.update_name(conn.assigns.current_user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Name successfully updated.")
        |> redirect(to: Routes.profile_path(conn, :show, user))

      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end
  end

  defp verify_authorized(conn, _opts) do
    case Canada.Can.can?(conn.assigns.current_user, :change_username, conn.assigns.current_user) do
      true -> conn
      _false -> IneedthisWeb.NotAuthorizedPlug.call(conn)
    end
  end
end
