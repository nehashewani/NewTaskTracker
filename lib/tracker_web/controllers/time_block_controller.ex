defmodule TrackerWeb.TimeBlockController do
  use TrackerWeb, :controller

  alias Tracker.TaskDetail
  alias Tracker.TaskDetail.TimeBlock

  action_fallback TrackerWeb.FallbackController

  def index(conn, _params) do
    timeblocks = TaskDetail.list_timeblocks()
    render(conn, "index.json", timeblocks: timeblocks)
  end

  def create(conn, %{"time_block" => time_block_params}) do
    with {:ok, %TimeBlock{} = time_block} <- TaskDetail.create_time_block(time_block_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", time_block_path(conn, :show, time_block))
      |> render("show.json", time_block: time_block)
    end
  end

  def show(conn, %{"id" => id}) do
    time_block = TaskDetail.get_time_block!(id)
    IO.puts(inspect(time_block))
    render(conn, "show.json", time_block: time_block)
  end

  def update(conn, %{"id" => id, "time_block" => time_block_params}) do
    time_block = TaskDetail.get_time_block!(id)

    with {:ok, %TimeBlock{} = time_block} <- TaskDetail.update_time_block(time_block, time_block_params) do
      render(conn, "show.json", time_block: time_block)
    end
  end

  def delete(conn, %{"id" => id}) do
    time_block = TaskDetail.get_time_block!(id)
    with {:ok, %TimeBlock{}} <- TaskDetail.delete_time_block(time_block) do
      #send_resp(conn, :no_content, "")
      task_trackers = TaskDetail.get_task_trackers!(time_block.taskdetails_id)
      time_blocks = TaskDetail.get_time_block_by_task_id(time_block.taskdetails_id)
      active_time_blocks = TaskDetail.get_active_time_block_by_task_id(time_block.taskdetails_id)
      conn
      #|> put_flash(:info, "Deleted")
      |> redirect(to: task_trackers_path(conn, :show, time_block.taskdetails_id))
      #render(conn, TrackerWeb.TaskTrackersView, "show.html", task_trackers: task_trackers, time_blocks: time_blocks, active_time_blocks: active_time_blocks)
      #render(conn, TasktrackerWeb.TaskView , "edit.html", task: task, changeset: changeset, users: users)
    end
  end

  def show(conn, %{"task_id" => id}) do
    time_block = TaskDetail.get_time_block_by_task_id(id)
    IO.puts(inspect(time_block))
    render(conn, "show.json", time_block: time_block)
  end

end
