defmodule Ineedthis.Config do
  def get(key) do
    Application.get_env(:ineedthis, :config)[key]
  end
end
