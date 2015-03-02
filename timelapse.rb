#!/usr/bin/ruby

# Project
project_name = "first"
system_username = "john"
project_path = "/home/#{system_username}/timelapse/#{project_name}"

# Video resolution
video_width = 1920
video_height = 1080

# Features
deflicker = true
resize = false
bulk_editing = false
add_music = false

#proper renaming and organizing of images in original directory
puts "Making sure all the directories exist."
dirs = ["original", "renamed", "bulk_edited", "cropped"]

dirs.each do |dir|
  unless File.directory?(dir)
    system 'mkdir', '-p', "#{project_path}/#{dir}"
    puts "====Made sure #{project_path}/#{dir} existed."
  end
end

originals = Dir.glob("#{project_path}/original/*.jpg")
sorted_origianls = originals.sort_by { |image| File.ctime(image) }

counter = 00000
puts "Renaming files"
sorted_origianls.each do |original|
  extension = File.extname(original)
  basemane = File.basename(original)
  renamed_file = "#{project_path}/renamed/#{project_name}_#{sprintf '%05d', counter}#{extension}"
  puts "====Coping original/#{basemane}#{extension} to #{renamed_file}"
  system 'cp', "#{original}", "#{renamed_file}"
  counter += 1
end

# deflickering
deflicker_source = "#{project_path}/renamed"
system 'cp', 'deflicker.pl', "#{deflicker_source}"
executable = "#{deflicker_source}/deflicker.pl"

if deflicker == true
  Dir.chdir(deflicker_source)
  system "perl #{executable}"
end

system 'mv' "#{project_path}/renamed/Deflickered" "#{project_path}/"

# any resizing that is nessecary

def resize_images(w, h)
  system 'convert' 'source' 'dest'
end

if resize == true
  resize_images(width, height)
end

# anconv uncompressed

# add music using sox

# final video compression for uploading

