defmodule IneedthisWeb.Image.ScrapeController do
  use IneedthisWeb, :controller

  alias Ineedthis.Scrapers

  def create(conn, params) do
    result =
      params
      |> Map.get("url")
      |> to_string()
      |> String.trim()
      |> Scrapers.scrape!()

    conn
    |> json(result)
  end
end
