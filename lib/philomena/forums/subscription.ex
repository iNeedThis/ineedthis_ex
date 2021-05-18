defmodule Ineedthis.Forums.Subscription do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ineedthis.Forums.Forum
  alias Ineedthis.Users.User

  @primary_key false

  schema "forum_subscriptions" do
    belongs_to :forum, Forum, primary_key: true
    belongs_to :user, User, primary_key: true
  end

  @doc false
  def changeset(subscription, attrs) do
    subscription
    |> cast(attrs, [])
    |> validate_required([])
  end
end
