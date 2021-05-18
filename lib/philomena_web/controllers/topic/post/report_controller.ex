defmodule IneedthisWeb.Topic.Post.ReportController do
  use IneedthisWeb, :controller

  alias IneedthisWeb.ReportController
  alias IneedthisWeb.ReportView
  alias Ineedthis.Forums.Forum
  alias Ineedthis.Reports.Report
  alias Ineedthis.Reports

  plug IneedthisWeb.FilterBannedUsersPlug
  plug IneedthisWeb.UserAttributionPlug
  plug IneedthisWeb.CaptchaPlug
  plug IneedthisWeb.CheckCaptchaPlug when action in [:create]

  plug IneedthisWeb.CanaryMapPlug, new: :show, create: :show

  plug :load_and_authorize_resource,
    model: Forum,
    id_name: "forum_id",
    id_field: "short_name",
    persisted: true

  plug IneedthisWeb.LoadTopicPlug
  plug IneedthisWeb.LoadPostPlug

  def new(conn, _params) do
    topic = conn.assigns.topic
    post = conn.assigns.post
    action = Routes.forum_topic_post_report_path(conn, :create, topic.forum, topic, post)

    changeset =
      %Report{reportable_type: "Post", reportable_id: post.id}
      |> Reports.change_report()

    conn
    |> put_view(ReportView)
    |> render("new.html", reportable: post, changeset: changeset, action: action)
  end

  def create(conn, params) do
    topic = conn.assigns.topic
    post = conn.assigns.post
    action = Routes.forum_topic_post_report_path(conn, :create, topic.forum, topic, post)

    ReportController.create(conn, action, post, "Post", params)
  end
end
