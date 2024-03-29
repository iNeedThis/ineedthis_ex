defmodule IneedthisWeb.Api.Json.ProfileView do
  use IneedthisWeb, :view

  def render("show.json", %{user: user} = assigns) do
    %{user: render_one(user, IneedthisWeb.Api.Json.ProfileView, "profile.json", assigns)}
  end

  def render("profile.json", %{user: user} = assigns) do
    %{
      id: user.id,
      name: user.name,
      slug: user.slug,
      role: role(user),
      description: user.description,
      avatar_url: avatar_url(user),
      created_at: user.created_at,
      comments_count: user.comments_posted_count,
      uploads_count: user.uploads_count,
      posts_count: user.forum_posts_count,
      topics_count: user.topic_count,
      links:
        render_many(
          user.public_links,
          IneedthisWeb.Api.Json.ArtistLinkView,
          "artist_link.json",
          assigns
        ),
      awards: render_many(user.awards, IneedthisWeb.Api.Json.AwardView, "award.json", assigns)
    }
  end

  defp role(%{hide_default_role: true}) do
    "user"
  end

  defp role(user) do
    user.role
  end

  defp avatar_url(%{avatar: nil}) do
    nil
  end

  defp avatar_url(user) do
    Application.get_env(:ineedthis, :avatar_url_root) <> "/" <> user.avatar
  end
end
