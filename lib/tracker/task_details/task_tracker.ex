defmodule Tracker.TaskDetails.TaskTracker do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tracker.TaskDetails.TaskTracker


  schema "tasks" do
    field :completion_status, :boolean, default: false
    field :desciption, :string
    field :time, :integer
    field :title, :string
    # field :user_id, :id
    belongs_to :user, Tracker.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%TaskTracker{} = task_tracker, attrs) do
    task_tracker
    |> cast(attrs, [:title, :desciption, :completion_status, :time, :user_id])
    |> validate_required([:title, :desciption, :completion_status, :time, :user_id])
  end
end
