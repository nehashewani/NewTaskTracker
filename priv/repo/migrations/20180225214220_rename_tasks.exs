defmodule Tracker.Repo.Migrations.RenameTasks do
  use Ecto.Migration

  def change do
   #alter table(:taskdetails) do
     # modify :time, :time, null: false
    #create table(:tasks) do
    #add :completion_status, :boolean, default: false
    #add :desciption, :string
    #add :time, :integer
    #add :title, :string
    #add :user_id, references(:users, on_delete: :delete_all), null: true
    
    #timestamps() 
    #end
    rename table("tasks"), to: table("taskdetails") 
  end
end
