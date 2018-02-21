defmodule Tracker.TaskDataTest do
  use Tracker.DataCase

  alias Tracker.TaskData

  describe "tasks" do
    alias Tracker.TaskData.Task

    @valid_attrs %{completion_status: true, desciption: "some desciption", time: 42, title: "some title"}
    @update_attrs %{completion_status: false, desciption: "some updated desciption", time: 43, title: "some updated title"}
    @invalid_attrs %{completion_status: nil, desciption: nil, time: nil, title: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TaskData.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert TaskData.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert TaskData.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = TaskData.create_task(@valid_attrs)
      assert task.completion_status == true
      assert task.desciption == "some desciption"
      assert task.time == 42
      assert task.title == "some title"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TaskData.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, task} = TaskData.update_task(task, @update_attrs)
      assert %Task{} = task
      assert task.completion_status == false
      assert task.desciption == "some updated desciption"
      assert task.time == 43
      assert task.title == "some updated title"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = TaskData.update_task(task, @invalid_attrs)
      assert task == TaskData.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = TaskData.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> TaskData.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = TaskData.change_task(task)
    end
  end

  describe "taskstracker" do
    alias Tracker.TaskData.Task

    @valid_attrs %{completion_status: true, desciption: "some desciption", time: 42, title: "some title"}
    @update_attrs %{completion_status: false, desciption: "some updated desciption", time: 43, title: "some updated title"}
    @invalid_attrs %{completion_status: nil, desciption: nil, time: nil, title: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TaskData.create_task()

      task
    end

    test "list_taskstracker/0 returns all taskstracker" do
      task = task_fixture()
      assert TaskData.list_taskstracker() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert TaskData.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = TaskData.create_task(@valid_attrs)
      assert task.completion_status == true
      assert task.desciption == "some desciption"
      assert task.time == 42
      assert task.title == "some title"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TaskData.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, task} = TaskData.update_task(task, @update_attrs)
      assert %Task{} = task
      assert task.completion_status == false
      assert task.desciption == "some updated desciption"
      assert task.time == 43
      assert task.title == "some updated title"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = TaskData.update_task(task, @invalid_attrs)
      assert task == TaskData.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = TaskData.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> TaskData.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = TaskData.change_task(task)
    end
  end

  describe "tasktrack" do
    alias Tracker.TaskData.Task

    @valid_attrs %{completion_status: true, desciption: "some desciption", time: 42, title: "some title"}
    @update_attrs %{completion_status: false, desciption: "some updated desciption", time: 43, title: "some updated title"}
    @invalid_attrs %{completion_status: nil, desciption: nil, time: nil, title: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TaskData.create_task()

      task
    end

    test "list_tasktrack/0 returns all tasktrack" do
      task = task_fixture()
      assert TaskData.list_tasktrack() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert TaskData.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = TaskData.create_task(@valid_attrs)
      assert task.completion_status == true
      assert task.desciption == "some desciption"
      assert task.time == 42
      assert task.title == "some title"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TaskData.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, task} = TaskData.update_task(task, @update_attrs)
      assert %Task{} = task
      assert task.completion_status == false
      assert task.desciption == "some updated desciption"
      assert task.time == 43
      assert task.title == "some updated title"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = TaskData.update_task(task, @invalid_attrs)
      assert task == TaskData.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = TaskData.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> TaskData.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = TaskData.change_task(task)
    end
  end
end
