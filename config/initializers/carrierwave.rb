CarrierWave.configure do |config|
  config.root = Settings.carrierwave.root
end

if Rails.env.development?
  CarrierWave.root = 'pictures'
end
