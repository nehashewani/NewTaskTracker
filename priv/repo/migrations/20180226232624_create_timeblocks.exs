defmodule Tracker.Repo.Migrations.CreateTimeblocks do
  use Ecto.Migration

  def change do
    create table(:timeblocks) do
      add :start_time, :naive_datetime
      add :end_time, :naive_datetime 
      add :taskdetails_id, references(:taskdetails, on_delete: :delete_all), null: false	
      timestamps()
    end

  end
end
