defmodule Ineedthis.Adverts.Uploader do
  @moduledoc """
  Upload and processing callback logic for Advert images.
  """

  alias Ineedthis.Adverts.Advert
  alias Ineedthis.Uploader

  def analyze_upload(advert, params) do
    Uploader.analyze_upload(advert, "image", params["image"], &Advert.image_changeset/2)
  end

  def persist_upload(advert) do
    Uploader.persist_upload(advert, advert_file_root(), "image")
  end

  def unpersist_old_upload(advert) do
    Uploader.unpersist_old_upload(advert, advert_file_root(), "image")
  end

  defp advert_file_root do
    Application.get_env(:ineedthis, :advert_file_root)
  end
end
