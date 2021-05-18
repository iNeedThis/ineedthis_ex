defmodule IneedthisWeb.Profile.ReportController do
  use IneedthisWeb, :controller

  alias IneedthisWeb.ReportController
  alias IneedthisWeb.ReportView
  alias Ineedthis.Users.User
  alias Ineedthis.Reports.Report
  alias Ineedthis.Reports

  plug IneedthisWeb.FilterBannedUsersPlug
  plug IneedthisWeb.UserAttributionPlug
  plug IneedthisWeb.CaptchaPlug
  plug IneedthisWeb.CheckCaptchaPlug when action in [:create]
  plug IneedthisWeb.CanaryMapPlug, new: :show, create: :show

  plug :load_and_authorize_resource,
    model: User,
    id_name: "profile_id",
    id_field: "slug",
    persisted: true

  def new(conn, _params) do
    user = conn.assigns.user
    action = Routes.profile_report_path(conn, :create, user)

    changeset =
      %Report{reportable_type: "User", reportable_id: user.id}
      |> Reports.change_report()

    conn
    |> put_view(ReportView)
    |> render("new.html",
      title: "Reporting User",
      reportable: user,
      changeset: changeset,
      action: action
    )
  end

  def create(conn, params) do
    user = conn.assigns.user
    action = Routes.profile_report_path(conn, :create, user)

    ReportController.create(conn, action, user, "User", params)
  end
end
