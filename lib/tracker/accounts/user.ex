defmodule Tracker.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tracker.Accounts.User


  schema "users" do
    field :email, :string
    field :name, :string
    has_many :taskdetails, Tracker.TaskDetail.TaskTrackers
    belongs_to :manager, User
    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :name, :manager_id])
    |> validate_required([:email, :name])
  end
end
