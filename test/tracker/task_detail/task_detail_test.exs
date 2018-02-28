defmodule Tracker.TaskDetailTest do
  use Tracker.DataCase

  alias Tracker.TaskDetail

  describe "taskdetails" do
    alias Tracker.TaskDetail.TaskTrackers

    @valid_attrs %{completion_status: true, desciption: "some desciption", time: 42, title: "some title"}
    @update_attrs %{completion_status: false, desciption: "some updated desciption", time: 43, title: "some updated title"}
    @invalid_attrs %{completion_status: nil, desciption: nil, time: nil, title: nil}

    def task_trackers_fixture(attrs \\ %{}) do
      {:ok, task_trackers} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TaskDetail.create_task_trackers()

      task_trackers
    end

    test "list_taskdetails/0 returns all taskdetails" do
      task_trackers = task_trackers_fixture()
      assert TaskDetail.list_taskdetails() == [task_trackers]
    end

    test "get_task_trackers!/1 returns the task_trackers with given id" do
      task_trackers = task_trackers_fixture()
      assert TaskDetail.get_task_trackers!(task_trackers.id) == task_trackers
    end

    test "create_task_trackers/1 with valid data creates a task_trackers" do
      assert {:ok, %TaskTrackers{} = task_trackers} = TaskDetail.create_task_trackers(@valid_attrs)
      assert task_trackers.completion_status == true
      assert task_trackers.desciption == "some desciption"
      assert task_trackers.time == 42
      assert task_trackers.title == "some title"
    end

    test "create_task_trackers/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TaskDetail.create_task_trackers(@invalid_attrs)
    end

    test "update_task_trackers/2 with valid data updates the task_trackers" do
      task_trackers = task_trackers_fixture()
      assert {:ok, task_trackers} = TaskDetail.update_task_trackers(task_trackers, @update_attrs)
      assert %TaskTrackers{} = task_trackers
      assert task_trackers.completion_status == false
      assert task_trackers.desciption == "some updated desciption"
      assert task_trackers.time == 43
      assert task_trackers.title == "some updated title"
    end

    test "update_task_trackers/2 with invalid data returns error changeset" do
      task_trackers = task_trackers_fixture()
      assert {:error, %Ecto.Changeset{}} = TaskDetail.update_task_trackers(task_trackers, @invalid_attrs)
      assert task_trackers == TaskDetail.get_task_trackers!(task_trackers.id)
    end

    test "delete_task_trackers/1 deletes the task_trackers" do
      task_trackers = task_trackers_fixture()
      assert {:ok, %TaskTrackers{}} = TaskDetail.delete_task_trackers(task_trackers)
      assert_raise Ecto.NoResultsError, fn -> TaskDetail.get_task_trackers!(task_trackers.id) end
    end

    test "change_task_trackers/1 returns a task_trackers changeset" do
      task_trackers = task_trackers_fixture()
      assert %Ecto.Changeset{} = TaskDetail.change_task_trackers(task_trackers)
    end
  end

  describe "timeblocks" do
    alias Tracker.TaskDetail.TimeBlock

    @valid_attrs %{end_time: ~N[2010-04-17 14:00:00.000000], start_time: ~N[2010-04-17 14:00:00.000000]}
    @update_attrs %{end_time: ~N[2011-05-18 15:01:01.000000], start_time: ~N[2011-05-18 15:01:01.000000]}
    @invalid_attrs %{end_time: nil, start_time: nil}

    def time_block_fixture(attrs \\ %{}) do
      {:ok, time_block} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TaskDetail.create_time_block()

      time_block
    end

    test "list_timeblocks/0 returns all timeblocks" do
      time_block = time_block_fixture()
      assert TaskDetail.list_timeblocks() == [time_block]
    end

    test "get_time_block!/1 returns the time_block with given id" do
      time_block = time_block_fixture()
      assert TaskDetail.get_time_block!(time_block.id) == time_block
    end

    test "create_time_block/1 with valid data creates a time_block" do
      assert {:ok, %TimeBlock{} = time_block} = TaskDetail.create_time_block(@valid_attrs)
      assert time_block.end_time == ~N[2010-04-17 14:00:00.000000]
      assert time_block.start_time == ~N[2010-04-17 14:00:00.000000]
    end

    test "create_time_block/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TaskDetail.create_time_block(@invalid_attrs)
    end

    test "update_time_block/2 with valid data updates the time_block" do
      time_block = time_block_fixture()
      assert {:ok, time_block} = TaskDetail.update_time_block(time_block, @update_attrs)
      assert %TimeBlock{} = time_block
      assert time_block.end_time == ~N[2011-05-18 15:01:01.000000]
      assert time_block.start_time == ~N[2011-05-18 15:01:01.000000]
    end

    test "update_time_block/2 with invalid data returns error changeset" do
      time_block = time_block_fixture()
      assert {:error, %Ecto.Changeset{}} = TaskDetail.update_time_block(time_block, @invalid_attrs)
      assert time_block == TaskDetail.get_time_block!(time_block.id)
    end

    test "delete_time_block/1 deletes the time_block" do
      time_block = time_block_fixture()
      assert {:ok, %TimeBlock{}} = TaskDetail.delete_time_block(time_block)
      assert_raise Ecto.NoResultsError, fn -> TaskDetail.get_time_block!(time_block.id) end
    end

    test "change_time_block/1 returns a time_block changeset" do
      time_block = time_block_fixture()
      assert %Ecto.Changeset{} = TaskDetail.change_time_block(time_block)
    end
  end
end
