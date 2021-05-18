defmodule Ineedthis.ImageHides.ImageHide do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ineedthis.Images.Image
  alias Ineedthis.Users.User

  @primary_key false

  schema "image_hides" do
    belongs_to :user, User, primary_key: true
    belongs_to :image, Image, primary_key: true
    timestamps(inserted_at: :created_at, updated_at: false, type: :utc_datetime)
  end

  @doc false
  def changeset(image_hide, attrs) do
    image_hide
    |> cast(attrs, [])
    |> validate_required([])
  end
end
