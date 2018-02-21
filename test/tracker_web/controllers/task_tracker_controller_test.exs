defmodule TrackerWeb.TaskTrackerControllerTest do
  use TrackerWeb.ConnCase

  alias Tracker.TaskDetails

  @create_attrs %{completion_status: true, desciption: "some desciption", time: 42, title: "some title"}
  @update_attrs %{completion_status: false, desciption: "some updated desciption", time: 43, title: "some updated title"}
  @invalid_attrs %{completion_status: nil, desciption: nil, time: nil, title: nil}

  def fixture(:task_tracker) do
    {:ok, task_tracker} = TaskDetails.create_task_tracker(@create_attrs)
    task_tracker
  end

  describe "index" do
    test "lists all tasks", %{conn: conn} do
      conn = get conn, task_tracker_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Tasks"
    end
  end

  describe "new task_tracker" do
    test "renders form", %{conn: conn} do
      conn = get conn, task_tracker_path(conn, :new)
      assert html_response(conn, 200) =~ "New Task tracker"
    end
  end

  describe "create task_tracker" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, task_tracker_path(conn, :create), task_tracker: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == task_tracker_path(conn, :show, id)

      conn = get conn, task_tracker_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Task tracker"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, task_tracker_path(conn, :create), task_tracker: @invalid_attrs
      assert html_response(conn, 200) =~ "New Task tracker"
    end
  end

  describe "edit task_tracker" do
    setup [:create_task_tracker]

    test "renders form for editing chosen task_tracker", %{conn: conn, task_tracker: task_tracker} do
      conn = get conn, task_tracker_path(conn, :edit, task_tracker)
      assert html_response(conn, 200) =~ "Edit Task tracker"
    end
  end

  describe "update task_tracker" do
    setup [:create_task_tracker]

    test "redirects when data is valid", %{conn: conn, task_tracker: task_tracker} do
      conn = put conn, task_tracker_path(conn, :update, task_tracker), task_tracker: @update_attrs
      assert redirected_to(conn) == task_tracker_path(conn, :show, task_tracker)

      conn = get conn, task_tracker_path(conn, :show, task_tracker)
      assert html_response(conn, 200) =~ "some updated desciption"
    end

    test "renders errors when data is invalid", %{conn: conn, task_tracker: task_tracker} do
      conn = put conn, task_tracker_path(conn, :update, task_tracker), task_tracker: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Task tracker"
    end
  end

  describe "delete task_tracker" do
    setup [:create_task_tracker]

    test "deletes chosen task_tracker", %{conn: conn, task_tracker: task_tracker} do
      conn = delete conn, task_tracker_path(conn, :delete, task_tracker)
      assert redirected_to(conn) == task_tracker_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, task_tracker_path(conn, :show, task_tracker)
      end
    end
  end

  defp create_task_tracker(_) do
    task_tracker = fixture(:task_tracker)
    {:ok, task_tracker: task_tracker}
  end
end
