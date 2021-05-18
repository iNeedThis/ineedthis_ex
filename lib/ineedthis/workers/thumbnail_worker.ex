defmodule Ineedthis.ThumbnailWorker do
  alias Ineedthis.Images.Thumbnailer

  def perform(image_id) do
    Thumbnailer.generate_thumbnails(image_id)

    IneedthisWeb.Endpoint.broadcast!(
      "firehose",
      "image:process",
      %{image_id: image_id}
    )
  end
end
