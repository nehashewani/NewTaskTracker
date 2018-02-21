defmodule Tracker.Repo.Migrations.Updatetaskdetails do
  use Ecto.Migration

  def change do
   alter table(:taskdetails) do
      modify :time, :time, null: false
      
  end 
end
end
