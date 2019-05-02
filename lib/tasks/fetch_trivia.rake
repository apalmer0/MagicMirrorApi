desc "Fetch random trivia question from jService"
task fetch_trivia: :environment do
  FetchTriviaService.run
end
