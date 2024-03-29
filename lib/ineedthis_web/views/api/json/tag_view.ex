defmodule IneedthisWeb.Api.Json.TagView do
  use IneedthisWeb, :view

  def render("index.json", %{tags: tags, total: total} = assigns) do
    %{
      tags: render_many(tags, IneedthisWeb.Api.Json.TagView, "tag.json", assigns),
      total: total
    }
  end

  def render("show.json", %{tag: tag} = assigns) do
    %{tag: render_one(tag, IneedthisWeb.Api.Json.TagView, "tag.json", assigns)}
  end

  def render("tag.json", %{tag: tag} = assigns) do
    %{
      id: tag.id,
      name: tag.name,
      slug: tag.slug,
      description: tag.description,
      short_description: tag.short_description,
      images: tag.images_count,
      spoiler_image_uri: tag_image(tag),
      namespace: tag.namespace,
      name_in_namespace: tag.name_in_namespace,
      category: tag.category,
      aliased_tag: aliased_tag(tag),
      aliases: Enum.map(tag.aliases, & &1.slug),
      implied_tags: Enum.map(tag.implied_tags, & &1.slug),
      implied_by_tags: Enum.map(tag.implied_by_tags, & &1.slug),
      dnp_entries:
        render_many(tag.dnp_entries, IneedthisWeb.Api.Json.DnpView, "dnp.json", assigns)
    }
  end

  defp aliased_tag(%{aliased_tag: nil}), do: nil
  defp aliased_tag(%{aliased_tag: t}), do: t.slug

  # TODO: copied from Tag.Fetch
  defp tag_image(%{image: image}) when image not in [nil, ""],
    do: tag_url_root() <> "/" <> image

  defp tag_image(_other),
    do: nil

  defp tag_url_root do
    Application.get_env(:ineedthis, :tag_url_root)
  end
end
