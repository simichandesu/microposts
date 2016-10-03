# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base  

  # RMagickをincludeします   
    include CarrierWave::RMagick
    
  # Choose what kind of storage to use for this uploader:
  if Rails.env.production?
    include cloudinary::CarrierWave
  else
    storage :file
  end
  
  process convert: 'jpg'
  
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

 # 画像の上限を700pxにする
  process :resize_to_limit => [700, 700]

  # サムネイルを生成する設定
  version :thumb do
    process :resize_to_limit => [300, 300]
  end

  def public_id
    model.id
  

end