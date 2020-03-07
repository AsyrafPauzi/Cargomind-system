CarrierWave.configure do |config|
    if Rails.env.staging? || Rails.env.production?
        config.fog_provider = 'fog/aws' 
        config.fog_credentials = {
          :provider => 'aws',
          :aws_access_key_id => ENV['AWS_ACCESS_KEY_ID'],
          :aws_secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
          :region => 'ap-southeast-1'
        }
        config.fog_directory = ENV['S3_BUCKET']
        config.storage = :fog
      else
        config.fog_provider = 'fog/aws' 
        config.fog_credentials = {
          :provider => 'aws',
          :aws_access_key_id => 'AKIAZ2Y6UQ2J7VNCEIBA',
          :aws_secret_access_key => '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',
          :region => 'ap-southeast-1'
        }
        config.fog_directory = 'cargomind-web'
        config.storage = :fog
        config.fog_public = true
      config.enable_processing = Rails.env.development?
    end
  end