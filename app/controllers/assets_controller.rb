class AssetsController < ApplicationController
  def handle
    file_name = "app/assets/#{params[:type]}/#{params[:name]}"
    if request[:format] == "css" && File.exist?(file_name.gsub('css', 'scss'))
      data = `sass #{file_name.gsub('css', 'scss')}`
    else
      data = File.read(file_name)
    end
    format_type = WEBrick::HTTPUtils::DefaultMimeTypes[request[:format]]
    render data, as: format_type
  end
end
