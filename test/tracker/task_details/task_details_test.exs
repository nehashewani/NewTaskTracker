defmodule Tracker.TaskDetailsTest do
  use Tracker.DataCase

  alias Tracker.TaskDetails

  describe "tasks" do
    alias Tracker.TaskDetails.TaskTracker

    @valid_attrs %{completion_status: true, desciption: "some desciption", time: 42, title: "some title"}
    @update_attrs %{completion_status: false, desciption: "some updated desciption", time: 43, title: "some updated title"}
    @invalid_attrs %{completion_status: nil, desciption: nil, time: nil, title: nil}

    def task_tracker_fixture(attrs \\ %{}) do
      {:ok, task_tracker} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TaskDetails.create_task_tracker()

      task_tracker
    end

    test "list_tasks/0 returns all tasks" do
      task_tracker = task_tracker_fixture()
      assert TaskDetails.list_tasks() == [task_tracker]
    end

    test "get_task_tracker!/1 returns the task_tracker with given id" do
      task_tracker = task_tracker_fixture()
      assert TaskDetails.get_task_tracker!(task_tracker.id) == task_tracker
    end

    test "create_task_tracker/1 with valid data creates a task_tracker" do
      assert {:ok, %TaskTracker{} = task_tracker} = TaskDetails.create_task_tracker(@valid_attrs)
      assert task_tracker.completion_status == true
      assert task_tracker.desciption == "some desciption"
      assert task_tracker.time == 42
      assert task_tracker.title == "some title"
    end

    test "create_task_tracker/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TaskDetails.create_task_tracker(@invalid_attrs)
    end

    test "update_task_tracker/2 with valid data updates the task_tracker" do
      task_tracker = task_tracker_fixture()
      assert {:ok, task_tracker} = TaskDetails.update_task_tracker(task_tracker, @update_attrs)
      assert %TaskTracker{} = task_tracker
      assert task_tracker.completion_status == false
      assert task_tracker.desciption == "some updated desciption"
      assert task_tracker.time == 43
      assert task_tracker.title == "some updated title"
    end

    test "update_task_tracker/2 with invalid data returns error changeset" do
      task_tracker = task_tracker_fixture()
      assert {:error, %Ecto.Changeset{}} = TaskDetails.update_task_tracker(task_tracker, @invalid_attrs)
      assert task_tracker == TaskDetails.get_task_tracker!(task_tracker.id)
    end

    test "delete_task_tracker/1 deletes the task_tracker" do
      task_tracker = task_tracker_fixture()
      assert {:ok, %TaskTracker{}} = TaskDetails.delete_task_tracker(task_tracker)
      assert_raise Ecto.NoResultsError, fn -> TaskDetails.get_task_tracker!(task_tracker.id) end
    end

    test "change_task_tracker/1 returns a task_tracker changeset" do
      task_tracker = task_tracker_fixture()
      assert %Ecto.Changeset{} = TaskDetails.change_task_tracker(task_tracker)
    end
  end
end
