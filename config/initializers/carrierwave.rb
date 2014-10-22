CarrierWave.configure do |config|
  config.root = Settings.carrierwave.root
end

if Rails.env.development? || Rails.env.production?
  CarrierWave.root = 'pictures'
end
