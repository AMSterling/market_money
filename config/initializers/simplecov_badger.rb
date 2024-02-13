# SimpleCov::Badger.configure do |config|
#   config.post_url = "coverage.traels.it/badges",
#   config.repo_url = `git config --get remote.origin.url`.strip,
#   config.run_if = -> { `git rev-parse --abbrev-ref HEAD` == "master\n" }
#   config.token = ENV["SIMPLECOV_BADGER_TOKEN"]
# end
