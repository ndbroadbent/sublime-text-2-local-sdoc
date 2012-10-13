# app.rb
require 'shellwords'
require "pty"

REPO_DIR="#{ENV['HOME']}/code"

helpers do
  def sdoc_root
    File.join(ENV['HOME'], ".sdoc", "merged_projects")
  end

  def file_path(path)
    File.expand_path(File.join(sdoc_root, path))
  end

  def code_path(path)
    File.expand_path(File.join(REPO_DIR, path))
  end
end

# Serve files from project directory
get "/projects/*" do
  logical_path = params[:splat].first
  file_path = file_path(logical_path)

  # Append 'index.html' to root directory
  if File.directory?(file_path)
    file_path << "/index.html"
  end

  return [400, "Can only serve files from #{sdoc_root}!"] if file_path.index(sdoc_root) != 0

  # Set mime type for css/js
  content_type :css if logical_path =~ /\.css$/
  content_type :js if logical_path =~ /\.js$/

  if File.exist?(file_path)
    File.read file_path
  else
    [404, "No such file at #{file_path}"]
  end
end

get "/favicon.ico" do
  404
end

post "/open_editor/" do
  if params[:file]
    `export DISPLAY=:0; sublime-text-2 #{params[:file].shellescape}:#{(params[:line] || "1").shellescape}`
  else
    "No file given."
  end
end