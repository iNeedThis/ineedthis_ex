defmodule Ineedthis.TagChanges.TagChange do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tag_changes" do
    belongs_to :user, Ineedthis.Users.User
    belongs_to :tag, Ineedthis.Tags.Tag
    belongs_to :image, Ineedthis.Images.Image

    field :ip, EctoNetwork.INET
    field :fingerprint, :string
    field :user_agent, :string, default: ""
    field :referrer, :string, default: ""
    field :added, :boolean
    field :tag_name_cache, :string, default: ""

    timestamps(inserted_at: :created_at, type: :utc_datetime)
  end

  @doc false
  def changeset(tag_change, attrs) do
    tag_change
    |> cast(attrs, [])
    |> validate_required([])
  end
end
