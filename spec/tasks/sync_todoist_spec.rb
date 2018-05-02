require "rails_helper"
require "rake"

describe "sync_todoist", type: :task do
  before(:all) do
    Rake.application.rake_require "tasks/sync_todoist"
    Rake::Task.define_task(:environment)
  end

  before { allow(TodoistSyncService).to receive(:sync) }

  it "runs the TodoistSyncService" do
    Rake::Task["sync_todoist"].execute

    expect(TodoistSyncService).to have_received(:sync)
  end
end
