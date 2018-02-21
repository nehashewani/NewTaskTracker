defmodule Tracker.TaskDetail do
  @moduledoc """
  The TaskDetail context.
  """

  import Ecto.Query, warn: false
  alias Tracker.Repo

  alias Tracker.TaskDetail.TaskTrackers
  alias Tracker.Account.User
  alias Tracker.Accounts

  @doc """
  Returns the list of taskdetails.

  ## Examples

      iex> list_taskdetails()
      [%TaskTrackers{}, ...]

  """
  def list_taskdetails do
    Repo.all(TaskTrackers)
   # |> Repo.preload(:user)
  end

  @doc """
  Gets a single task_trackers.

  Raises `Ecto.NoResultsError` if the Task trackers does not exist.

  ## Examples

      iex> get_task_trackers!(123)
      %TaskTrackers{}

      iex> get_task_trackers!(456)
      ** (Ecto.NoResultsError)

  """
  def get_task_trackers!(id) do
    Repo.get!(TaskTrackers, id)
    |> Repo.preload(:user)
  end

  @doc """
  Creates a task_trackers.

  ## Examples

      iex> create_task_trackers(%{field: value})
      {:ok, %TaskTrackers{}}

      iex> create_task_trackers(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_task_trackers(attrs \\ %{}) do
    %TaskTrackers{}
    |> TaskTrackers.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a task_trackers.

  ## Examples

      iex> update_task_trackers(task_trackers, %{field: new_value})
      {:ok, %TaskTrackers{}}

      iex> update_task_trackers(task_trackers, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_task_trackers(%TaskTrackers{} = task_trackers, attrs) do
    task_trackers
    |> TaskTrackers.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a TaskTrackers.

  ## Examples

      iex> delete_task_trackers(task_trackers)
      {:ok, %TaskTrackers{}}

      iex> delete_task_trackers(task_trackers)
      {:error, %Ecto.Changeset{}}

  """
  def delete_task_trackers(%TaskTrackers{} = task_trackers) do
    Repo.delete(task_trackers)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task_trackers changes.

  ## Examples

      iex> change_task_trackers(task_trackers)
      %Ecto.Changeset{source: %TaskTrackers{}}

  """
  def change_task_trackers(%TaskTrackers{} = task_trackers) do
    TaskTrackers.changeset(task_trackers, %{})
  end
  
  def get_user_tasks(user_id) do 
   q = from t in TaskTrackers, where: t.user_id == ^user_id
   Repo.all(q)
   |> Repo.preload(:user)
  end
  
  def assign_tasks_to_admin(user_id) do
    admin = Accounts.get_user_by_email("admin@admin.com")
    q = from t in Tracker.TaskDetail.TaskTrackers, where: t.user_id == ^user_id
    IO.puts(inspect(admin))
    #Repo.all(TaskTrackers, user_id: user_id)
    #|> Repo.update_all(set: [user_id: admin.id])
    #Repo.all(q)
    #changeset = Ecto.Changeset.put_change(changeset,:user_id, admin.id)
    #|> Repo.update_all([])
    #|> Repo.preload(:user)
    #|> Repo.update_all([])
  end
end
