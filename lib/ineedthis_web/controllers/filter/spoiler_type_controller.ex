defmodule IneedthisWeb.Filter.SpoilerTypeController do
  use IneedthisWeb, :controller

  alias Ineedthis.Users

  plug IneedthisWeb.RequireUserPlug

  def update(conn, %{"user" => user_params}) do
    {:ok, user} = Users.update_spoiler_type(conn.assigns.current_user, user_params)

    conn
    |> put_flash(:info, "Changed spoiler type to #{user.spoiler_type}")
    |> redirect(external: conn.assigns.referrer)
  end
end
