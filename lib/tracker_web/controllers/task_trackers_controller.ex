defmodule TrackerWeb.TaskTrackersController do
  use TrackerWeb, :controller

  alias Tracker.TaskDetail
  alias Tracker.TaskDetail.TaskTrackers
  alias Tracker.Accounts
  alias Tracker.Accounts.User
  alias Tracker.Repo
  alias TrackerWeb.Router
  alias TrackerWeb.SessionController

  def index(conn, _params) do
    taskdetails = nil
    emptasks = nil
    IO.puts(inspect(conn.assigns[:current_user]))
    if conn.assigns[:current_user].name == "admin" do
    	taskdetails = TaskDetail.list_taskdetails()
    else
    	taskdetails = make_assoc(conn.assigns[:current_user]) |> Tracker.Repo.all()
      emptasks = TaskDetail.get_employee_tasks(conn.assigns[:current_user].id)
    end
    render(conn, "index.html", taskdetails: taskdetails, emptasks: emptasks)
  end

  def new(conn, _params) do
    #changeset = TaskDetail.change_task_trackers(%TaskTrackers{})
    user_tasks =  conn.assigns[:current_user]
    users = Tracker.Accounts.get_employees(user_tasks.id) |> Enum.map(&{&1.name, &1.id})


    #changeset = Tracker.TaskDetail.change_task_trackers(Tracker.TaskDetail.TaskTrackers)
    #render conn, "tasks.html", changeset: changeset, users: users
    changeset = Ecto.build_assoc(user_tasks, :taskdetails,  %Tracker.TaskDetail.TaskTrackers{}) |> TaskTrackers.changeset(_params)
    render(conn, "new.html", changeset: changeset, users: users)
  end

  def create(conn, %{"task_trackers" => task_trackers_params}) do
    IO.puts(inspect(task_trackers_params))
    total_minutes = elem(Integer.parse(Map.get(task_trackers_params, "time")), 0) * 60 + elem(Integer.parse(Map.get(task_trackers_params, "min")), 0)
    task_trackers_params = Map.put(task_trackers_params, "time", total_minutes)
    #total_time = Map.get(task_trackers_params, "time")
    #task_trackers_params = %{task_trackers_params | time: div(total_time,60)}
    user_tasks =  conn.assigns[:current_user]
    users = Tracker.Accounts.list_users() |> Enum.map(&{&1.name, &1.id})
    #user_tasks = %Tracker.TaskDetail.TaskTrackers{ user_id: conn.assigns[:current_user].id }
    changeset = Ecto.build_assoc(user_tasks, :taskdetails,  %Tracker.TaskDetail.TaskTrackers{}) |> TaskTrackers.changeset(task_trackers_params)
     case TaskDetail.create_task_trackers(task_trackers_params) do
      {:ok, task_trackers} ->
        conn
        |> put_flash(:info, "Task trackers created successfully.")
        |> redirect(to: task_trackers_path(conn, :show, task_trackers))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, users: users)
    end
  end

  def show(conn, %{"id" => id}) do
    task_trackers = TaskDetail.get_task_trackers!(id)
    time_blocks = TaskDetail.get_time_block_by_task_id(id)
    active_time_blocks = TaskDetail.get_active_time_block_by_task_id(id)
    render(conn, "show.html", task_trackers: task_trackers, time_blocks: time_blocks, active_time_blocks: active_time_blocks)
  end

  def edit(conn, %{"id" => id}) do
    task_trackers = TaskDetail.get_task_trackers!(id)
    IO.puts(inspect(task_trackers))
    user = conn.assigns[:current_user]
    users = Tracker.Accounts.get_employees(user.id) |> Enum.map(&{&1.name, &1.id})
    changeset = TaskDetail.change_task_trackers(task_trackers)
    time_val = Ecto.Changeset.get_field(changeset, :time)
    changeset = Ecto.Changeset.put_change(changeset, :time, div(time_val, 60))
    changeset = Ecto.Changeset.put_change(changeset, :min, rem(time_val,60))
    render(conn, "edit.html", task_trackers: task_trackers, changeset: changeset, users: users)
  end

  def update(conn, %{"id" => id, "task_trackers" => task_trackers_params}) do
    task_trackers = TaskDetail.get_task_trackers!(id)
    total_minutes = elem(Integer.parse(Map.get(task_trackers_params, "time")), 0) * 60 + elem(Integer.parse(Map.get(task_trackers_params, "min")), 0)
    task_trackers_params = Map.put(task_trackers_params, "time", total_minutes)
    IO.puts(inspect(Map.get(task_trackers_params, "time")))
    #task_trackers_params = Map.put(task_trackers_params, "time", total_minutes)
    users = Tracker.Accounts.list_users() |> Enum.map(&{&1.name, &1.id})
    case TaskDetail.update_task_trackers(task_trackers, task_trackers_params) do
      {:ok, task_trackers} ->
        conn
        |> put_flash(:info, "Task trackers updated successfully.")
        |> redirect(to: task_trackers_path(conn, :show, task_trackers))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task_trackers: task_trackers, changeset: changeset, users: users)
    end
  end

  def delete(conn, %{"id" => id}) do
    task_trackers = TaskDetail.get_task_trackers!(id)
    {:ok, _task_trackers} = TaskDetail.delete_task_trackers(task_trackers)

    conn
    |> put_flash(:info, "Task trackers deleted successfully.")
    |> redirect(to: task_trackers_path(conn, :index))
  end

  def make_assoc(user) do
    Ecto.assoc(user, :taskdetails)
  end

  def editime(conn, %{"id" => id}) do
    time_block = TaskDetail.get_time_block!(id)
    render(conn, "time.html", time_block: time_block)
  end
end
