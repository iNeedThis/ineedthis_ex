defmodule IneedthisWeb.Admin.AdvertController do
  use IneedthisWeb, :controller

  alias Ineedthis.Adverts.Advert
  alias Ineedthis.Adverts
  alias Ineedthis.Repo
  import Ecto.Query

  plug :verify_authorized
  plug :load_and_authorize_resource, model: Advert, only: [:edit, :update, :delete]

  def index(conn, _params) do
    adverts =
      Advert
      |> order_by(desc: :finish_date)
      |> Repo.paginate(conn.assigns.scrivener)

    render(conn, "index.html",
      title: "Admin - Adverts",
      layout_class: "layout--wide",
      adverts: adverts
    )
  end

  def new(conn, _params) do
    changeset = Adverts.change_advert(%Advert{})
    render(conn, "new.html", title: "New Advert", changeset: changeset)
  end

  def create(conn, %{"advert" => advert_params}) do
    case Adverts.create_advert(advert_params) do
      {:ok, _advert} ->
        conn
        |> put_flash(:info, "Advert was successfully created.")
        |> redirect(to: Routes.admin_advert_path(conn, :index))

      {:error, :advert, changeset, _changes} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, _params) do
    changeset = Adverts.change_advert(conn.assigns.advert)
    render(conn, "edit.html", title: "Editing Advert", changeset: changeset)
  end

  def update(conn, %{"advert" => advert_params}) do
    case Adverts.update_advert(conn.assigns.advert, advert_params) do
      {:ok, _advert} ->
        conn
        |> put_flash(:info, "Advert was successfully updated.")
        |> redirect(to: Routes.admin_advert_path(conn, :index))

      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end
  end

  def delete(conn, _params) do
    {:ok, _advert} = Adverts.delete_advert(conn.assigns.advert)

    conn
    |> put_flash(:info, "Advert was successfully deleted.")
    |> redirect(to: Routes.admin_advert_path(conn, :index))
  end

  defp verify_authorized(conn, _opts) do
    case Canada.Can.can?(conn.assigns.current_user, :index, Advert) do
      true -> conn
      false -> IneedthisWeb.NotAuthorizedPlug.call(conn)
    end
  end
end
