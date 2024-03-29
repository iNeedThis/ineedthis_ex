defmodule Ineedthis.Users.Role do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ineedthis.Users.User
  alias Ineedthis.Roles.Role

  @primary_key false

  schema "users_roles" do
    belongs_to :user, User, primary_key: true
    belongs_to :role, Role, primary_key: true
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [])
    |> validate_required([])
  end
end
