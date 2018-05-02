desc "Sync with Todoist"
task sync_todoist: :environment do
  TodoistSyncService.sync
end
