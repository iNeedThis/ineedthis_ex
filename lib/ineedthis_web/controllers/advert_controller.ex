defmodule IneedthisWeb.AdvertController do
  use IneedthisWeb, :controller

  alias IneedthisWeb.AdvertUpdater
  alias Ineedthis.Adverts.Advert

  plug :load_resource, model: Advert

  def show(conn, _params) do
    advert = conn.assigns.advert

    AdvertUpdater.cast(:click, advert.id)

    redirect(conn, external: advert.link)
  end
end
