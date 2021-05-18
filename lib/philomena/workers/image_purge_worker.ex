defmodule Ineedthis.ImagePurgeWorker do
  alias Ineedthis.Images

  def perform(files) do
    Images.perform_purge(files)
  end
end
