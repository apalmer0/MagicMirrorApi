desc "Sync with Todoist"
task sync_todoist: :environment do
  TodoistService.sync
end
