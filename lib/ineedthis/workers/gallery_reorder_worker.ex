defmodule Ineedthis.GalleryReorderWorker do
  alias Ineedthis.Galleries

  def perform(gallery_id, image_ids) do
    Galleries.perform_reorder(gallery_id, image_ids)
  end
end
