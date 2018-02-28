defmodule Tracker.Repo.Migrations.AlterTimeblocks do
  use Ecto.Migration
#def alter_time_blocks do
	def change do
	alter table(:timeblocks) do
		modify :end_time, :datetime, null: true
	end
	end
end
