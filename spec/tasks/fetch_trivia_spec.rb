require "rails_helper"
require "rake"

describe "fetch_trivia", type: :task do
  before(:all) do
    Rake.application.rake_require "tasks/fetch_trivia"
    Rake::Task.define_task(:environment)
  end

  before { allow(FetchTriviaService).to receive(:run) }

  it "runs the FetchTriviaService" do
    Rake::Task["fetch_trivia"].execute

    expect(FetchTriviaService).to have_received(:run)
  end
end
