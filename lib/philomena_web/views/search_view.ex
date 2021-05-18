defmodule IneedthisWeb.SearchView do
  use IneedthisWeb, :view

  def scope(conn), do: IneedthisWeb.ImageScope.scope(conn)
  def hides_images?(conn), do: can?(conn, :hide, %Ineedthis.Images.Image{})
end
