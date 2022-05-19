Cloudinary.config do |config|
  config.cloud_name = ENV['CLOUDINARY_CLOUD_NAME']
  config.api_key = ENV['CLOUDINARY_API_KEY']
  config.api_secret = ENV['CLOUDINARY_SECRET_ACCESS_KEY']
  config.secure = true
  config.enhance_image_tag = true
  config.static_file_support = true
end