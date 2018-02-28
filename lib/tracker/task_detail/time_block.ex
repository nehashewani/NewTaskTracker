defmodule Tracker.TaskDetail.TimeBlock do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tracker.TaskDetail.TimeBlock


  schema "timeblocks" do
    field :end_time, :naive_datetime
    field :start_time, :naive_datetime
    belongs_to :taskdetails, Tracker.TaskDetail.TaskTrackers
    timestamps()
  end

  @doc false
  def changeset(%TimeBlock{} = time_block, attrs) do
    time_block
    |> cast(attrs, [:start_time, :end_time, :taskdetails_id])
    #|> validate_required([:start_time, :end_time])
  end
end
