defmodule IneedthisWeb.PostView do
  alias Ineedthis.Attribution
  alias Ineedthis.Textile.Parser

  use IneedthisWeb, :view

  def textile_safe_author(object) do
    author_name = author_name(object)
    at_author_name = "@" <> author_name

    Parser.parse(%{image_transform: & &1}, at_author_name)
    |> Parser.flatten()
    |> case do
      ^at_author_name ->
        author_name

      _ ->
        # Cover *all* possibilities.
        literal =
          author_name
          |> String.replace("==]", "==]==][==")

        "[==#{literal}==]"
    end
  end

  defp author_name(object) do
    cond do
      Attribution.anonymous?(object) || !object.user ->
        IneedthisWeb.UserAttributionView.anonymous_name(object)

      true ->
        object.user.name
    end
  end
end
