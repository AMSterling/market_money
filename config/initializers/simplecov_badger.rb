if Module.const_defined? "SimpleCov"
  SimpleCov::Badger.configure do |config|
  config.token = ENV["SIMPLECOV_BADGER_TOKEN"]  end
end
