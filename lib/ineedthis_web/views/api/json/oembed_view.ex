defmodule IneedthisWeb.Api.Json.OembedView do
  use IneedthisWeb, :view

  def render("error.json", _assigns) do
    %{
      error: "Couldn't find an image"
    }
  end

  def render("show.json", %{image: image}) do
    %{
      version: "1.0",
      type: "photo",
      title: "##{image.id} - #{image.tag_list_cache} - ineedthis",
      author_url: image.source_url || "",
      author_name: artist_tags(image.tags),
      provider_name: "ineedthis",
      provider_url: IneedthisWeb.Endpoint.url(),
      cache_age: 7200,
      ineedthis_id: image.id,
      ineedthis_score: image.score,
      ineedthis_comments: image.comments_count,
      ineedthis_tags: Enum.map(image.tags, & &1.name)
    }
  end

  defp artist_tags(tags) do
    tags
    |> Enum.filter(&(&1.namespace == "artist"))
    |> Enum.map_join(", ", & &1.name_in_namespace)
  end
end
