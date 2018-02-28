defmodule Tracker.TaskDetail.TaskTrackers do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tracker.TaskDetail.TaskTrackers
  alias Tracker.Accounts.User


  schema "taskdetails" do
    field :completion_status, :boolean, default: false
    field :desciption, :string
    field :time, :integer
    field :title, :string
    #field :user_id, :id
    belongs_to :user, User
    has_many :timeblocks, TimeBlock, foreign_key: :taskdetails_id
    timestamps()
  end

  @doc false
  def changeset(%TaskTrackers{} = task_trackers, attrs) do
    task_trackers
    |> cast(attrs, [:title, :desciption, :completion_status, :time, :user_id])
    |> validate_required([:title, :desciption, :completion_status, :time, :user_id])
  end
end
