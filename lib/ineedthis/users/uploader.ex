defmodule Ineedthis.Users.Uploader do
  @moduledoc """
  Upload and processing callback logic for User avatars.
  """

  alias Ineedthis.Users.User
  alias Ineedthis.Uploader

  def analyze_upload(user, params) do
    Uploader.analyze_upload(user, "avatar", params["avatar"], &User.avatar_changeset/2)
  end

  def persist_upload(user) do
    Uploader.persist_upload(user, avatar_file_root(), "avatar")
  end

  def unpersist_old_upload(user) do
    Uploader.unpersist_old_upload(user, avatar_file_root(), "avatar")
  end

  defp avatar_file_root do
    Application.get_env(:ineedthis, :avatar_file_root)
  end
end