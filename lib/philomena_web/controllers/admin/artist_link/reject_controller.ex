defmodule IneedthisWeb.Admin.ArtistLink.RejectController do
  use IneedthisWeb, :controller

  alias Ineedthis.ArtistLinks.ArtistLink
  alias Ineedthis.ArtistLinks

  plug IneedthisWeb.CanaryMapPlug, create: :edit

  plug :load_and_authorize_resource,
    model: ArtistLink,
    id_name: "artist_link_id",
    persisted: true,
    preload: [:user]

  def create(conn, _params) do
    {:ok, _} = ArtistLinks.reject_artist_link(conn.assigns.artist_link)

    conn
    |> put_flash(:info, "Artist link successfully marked as rejected.")
    |> redirect(to: Routes.admin_artist_link_path(conn, :index))
  end
end
