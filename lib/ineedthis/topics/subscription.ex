defmodule Ineedthis.Topics.Subscription do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false

  schema "topic_subscriptions" do
    belongs_to :topic, Ineedthis.Topics.Topic, primary_key: true
    belongs_to :user, Ineedthis.Users.User, primary_key: true
  end

  @doc false
  def changeset(subscription, attrs) do
    subscription
    |> cast(attrs, [])
    |> validate_required([])
  end
end
