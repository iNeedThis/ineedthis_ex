defmodule IneedthisWeb.Api.Json.DnpView do
  use IneedthisWeb, :view

  def render("index.json", %{dnps: dnp, total: total} = assigns) do
    %{
      dnps: render_many(dnp, IneedthisWeb.Api.Json.DnpView, "dnp.json", assigns),
      total: total
    }
  end

  def render("show.json", %{dnp: dnp} = assigns) do
    %{dnp: render_one(dnp, IneedthisWeb.Api.Json.DnpView, "dnp.json", assigns)}
  end

  def render("dnp.json", %{dnp: dnp}) do
    %{
      id: dnp.id,
      dnp_type: dnp.dnp_type,
      conditions: dnp.conditions,
      reason: if(!dnp.hide_reason, do: dnp.reason),
      created_at: dnp.created_at
    }
  end
end
