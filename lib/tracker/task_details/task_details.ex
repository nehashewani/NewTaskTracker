defmodule Tracker.TaskDetails do
  @moduledoc """
  The TaskDetails context.
  """

  import Ecto.Query, warn: false
  alias Tracker.Repo

  alias Tracker.TaskDetails.TaskTracker

  @doc """
  Returns the list of tasks.

  ## Examples

      iex> list_tasks()
      [%TaskTracker{}, ...]

  """
  def list_tasks do
    Repo.all(TaskTracker)
  end

  @doc """
  Gets a single task_tracker.

  Raises `Ecto.NoResultsError` if the Task tracker does not exist.

  ## Examples

      iex> get_task_tracker!(123)
      %TaskTracker{}

      iex> get_task_tracker!(456)
      ** (Ecto.NoResultsError)

  """
  def get_task_tracker!(id), do: Repo.get!(TaskTracker, id)

  @doc """
  Creates a task_tracker.

  ## Examples

      iex> create_task_tracker(%{field: value})
      {:ok, %TaskTracker{}}

      iex> create_task_tracker(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_task_tracker(attrs \\ %{}) do
    %TaskTracker{}
    |> TaskTracker.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a task_tracker.

  ## Examples

      iex> update_task_tracker(task_tracker, %{field: new_value})
      {:ok, %TaskTracker{}}

      iex> update_task_tracker(task_tracker, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_task_tracker(%TaskTracker{} = task_tracker, attrs) do
    task_tracker
    |> TaskTracker.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a TaskTracker.

  ## Examples

      iex> delete_task_tracker(task_tracker)
      {:ok, %TaskTracker{}}

      iex> delete_task_tracker(task_tracker)
      {:error, %Ecto.Changeset{}}

  """
  def delete_task_tracker(%TaskTracker{} = task_tracker) do
    Repo.delete(task_tracker)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task_tracker changes.

  ## Examples

      iex> change_task_tracker(task_tracker)
      %Ecto.Changeset{source: %TaskTracker{}}

  """
  def change_task_tracker(%TaskTracker{} = task_tracker) do
    TaskTracker.changeset(task_tracker, %{})
  end
end
