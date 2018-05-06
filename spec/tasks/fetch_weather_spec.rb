require "rails_helper"
require "rake"

describe "fetch_weather", type: :task do
  before(:all) do
    Rake.application.rake_require "tasks/fetch_weather"
    Rake::Task.define_task(:environment)
  end

  before { allow(DarkSkyService).to receive(:fetch_weather) }

  it "runs the DarkSkyService" do
    Rake::Task["fetch_weather"].execute

    expect(DarkSkyService).to have_received(:fetch_weather)
  end
end
