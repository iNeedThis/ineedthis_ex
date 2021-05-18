defmodule Ineedthis.Images.Source do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ineedthis.Images.Image

  schema "image_sources" do
    belongs_to :image, Image
    field :source, :string
  end

  @doc false
  def changeset(source, attrs) do
    source
    |> cast(attrs, [])
    |> validate_required([])
  end
end
