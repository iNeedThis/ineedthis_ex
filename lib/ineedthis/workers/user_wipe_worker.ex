defmodule Ineedthis.UserWipeWorker do
  alias Ineedthis.UserWipe

  def perform(user_id) do
    UserWipe.perform(user_id)
  end
end
