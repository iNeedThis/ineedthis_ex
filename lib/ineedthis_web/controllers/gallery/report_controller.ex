defmodule IneedthisWeb.Gallery.ReportController do
  use IneedthisWeb, :controller

  alias IneedthisWeb.ReportController
  alias IneedthisWeb.ReportView
  alias Ineedthis.Galleries.Gallery
  alias Ineedthis.Reports.Report
  alias Ineedthis.Reports

  plug IneedthisWeb.FilterBannedUsersPlug
  plug IneedthisWeb.UserAttributionPlug
  plug IneedthisWeb.CaptchaPlug
  plug IneedthisWeb.CheckCaptchaPlug when action in [:create]
  plug IneedthisWeb.CanaryMapPlug, new: :show, create: :show

  plug :load_and_authorize_resource,
    model: Gallery,
    id_name: "gallery_id",
    persisted: true,
    preload: [:creator]

  def new(conn, _params) do
    gallery = conn.assigns.gallery
    action = Routes.gallery_report_path(conn, :create, gallery)

    changeset =
      %Report{reportable_type: "Gallery", reportable_id: gallery.id}
      |> Reports.change_report()

    conn
    |> put_view(ReportView)
    |> render("new.html",
      title: "Reporting Gallery",
      reportable: gallery,
      changeset: changeset,
      action: action
    )
  end

  def create(conn, params) do
    gallery = conn.assigns.gallery
    action = Routes.gallery_report_path(conn, :create, gallery)

    ReportController.create(conn, action, gallery, "Gallery", params)
  end
end
