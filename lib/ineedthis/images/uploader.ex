defmodule Ineedthis.Images.Uploader do
  @moduledoc """
  Upload and processing callback logic for Images.
  """

  alias Ineedthis.Images.Image
  alias Ineedthis.Uploader

  def analyze_upload(image, params) do
    Uploader.analyze_upload(image, "image", params["image"], &Image.image_changeset/2)
  end

  def persist_upload(image) do
    Uploader.persist_upload(image, image_file_root(), "image")
  end

  def unpersist_old_upload(image) do
    Uploader.unpersist_old_upload(image, image_file_root(), "image")
  end

  defp image_file_root do
    Application.get_env(:ineedthis, :image_file_root)
  end
end
