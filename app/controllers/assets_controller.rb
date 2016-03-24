class AssetsController < ApplicationController
  def handle
    data = File.read("app/assets/#{params[:type]}/#{params[:name]}")
    format_type = WEBrick::HTTPUtils::DefaultMimeTypes[request[:format]]
    render data, as: format_type
  end
end
