defmodule IneedthisWeb.Profile.DescriptionController do
  use IneedthisWeb, :controller

  alias Ineedthis.Users.User
  alias Ineedthis.Users

  plug IneedthisWeb.FilterBannedUsersPlug
  plug IneedthisWeb.CanaryMapPlug, edit: :edit_description, update: :edit_description

  plug :load_and_authorize_resource,
    model: User,
    id_name: "profile_id",
    id_field: "slug",
    persisted: true

  def edit(conn, _params) do
    changeset = Users.change_user(conn.assigns.user)

    render(conn, "edit.html",
      title: "Editing Profile Description",
      changeset: changeset,
      user: conn.assigns.user
    )
  end

  def update(conn, %{"user" => user_params}) do
    user = conn.assigns.user

    case Users.update_description(user, user_params) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "Description successfully updated.")
        |> redirect(to: Routes.profile_path(conn, :show, user))

      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end
  end
end
