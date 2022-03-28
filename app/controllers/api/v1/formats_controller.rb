class Api::V1::FormatsController < ApplicationController
  def index
    formats = Format.all
    render :json => formats
  end
end
