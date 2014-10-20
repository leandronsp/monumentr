CarrierWave.configure do |config|
  config.root = File.join(Rails.root, (Rails.env.test? ? 'test' : 'pictures'))
end
