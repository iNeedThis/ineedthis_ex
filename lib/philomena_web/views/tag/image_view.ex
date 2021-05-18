defmodule IneedthisWeb.Tag.ImageView do
  use IneedthisWeb, :view

  alias IneedthisWeb.TagView

  defp tag_image(tag),
    do: TagView.tag_image(tag)
end
