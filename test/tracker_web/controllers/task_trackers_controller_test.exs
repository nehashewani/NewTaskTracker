defmodule TrackerWeb.TaskTrackersControllerTest do
  use TrackerWeb.ConnCase

  alias Tracker.TaskDetail

  @create_attrs %{completion_status: true, desciption: "some desciption", time: 42, title: "some title"}
  @update_attrs %{completion_status: false, desciption: "some updated desciption", time: 43, title: "some updated title"}
  @invalid_attrs %{completion_status: nil, desciption: nil, time: nil, title: nil}

  def fixture(:task_trackers) do
    {:ok, task_trackers} = TaskDetail.create_task_trackers(@create_attrs)
    task_trackers
  end

  describe "index" do
    test "lists all taskdetails", %{conn: conn} do
      conn = get conn, task_trackers_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Taskdetails"
    end
  end

  describe "new task_trackers" do
    test "renders form", %{conn: conn} do
      conn = get conn, task_trackers_path(conn, :new)
      assert html_response(conn, 200) =~ "New Task trackers"
    end
  end

  describe "create task_trackers" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, task_trackers_path(conn, :create), task_trackers: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == task_trackers_path(conn, :show, id)

      conn = get conn, task_trackers_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Task trackers"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, task_trackers_path(conn, :create), task_trackers: @invalid_attrs
      assert html_response(conn, 200) =~ "New Task trackers"
    end
  end

  describe "edit task_trackers" do
    setup [:create_task_trackers]

    test "renders form for editing chosen task_trackers", %{conn: conn, task_trackers: task_trackers} do
      conn = get conn, task_trackers_path(conn, :edit, task_trackers)
      assert html_response(conn, 200) =~ "Edit Task trackers"
    end
  end

  describe "update task_trackers" do
    setup [:create_task_trackers]

    test "redirects when data is valid", %{conn: conn, task_trackers: task_trackers} do
      conn = put conn, task_trackers_path(conn, :update, task_trackers), task_trackers: @update_attrs
      assert redirected_to(conn) == task_trackers_path(conn, :show, task_trackers)

      conn = get conn, task_trackers_path(conn, :show, task_trackers)
      assert html_response(conn, 200) =~ "some updated desciption"
    end

    test "renders errors when data is invalid", %{conn: conn, task_trackers: task_trackers} do
      conn = put conn, task_trackers_path(conn, :update, task_trackers), task_trackers: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Task trackers"
    end
  end

  describe "delete task_trackers" do
    setup [:create_task_trackers]

    test "deletes chosen task_trackers", %{conn: conn, task_trackers: task_trackers} do
      conn = delete conn, task_trackers_path(conn, :delete, task_trackers)
      assert redirected_to(conn) == task_trackers_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, task_trackers_path(conn, :show, task_trackers)
      end
    end
  end

  defp create_task_trackers(_) do
    task_trackers = fixture(:task_trackers)
    {:ok, task_trackers: task_trackers}
  end
end
