defmodule TrackerWeb.PageController do
  use TrackerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def userhome(conn, _params) do
    render conn, "userhome.html"
  end

  #def tasks(conn, _params) do
   # users = Tracker.TaskDetail.list_taskdetails() |> Enum.map(&{&1.name, &1.id})
    #some_tasks = %Tracker.TaskDetail.TaskTrackers{ user_id: conn.assigns[:current_user].id }
   # changeset = Tracker.TaskDetail.change_task_trackers(Tracker.TaskDetail.TaskTrackers)
    #render conn, "tasks.html", changeset: changeset, users: users
 # end
end
