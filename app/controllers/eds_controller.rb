require 'slim'

class EdsController < ApplicationController
  def index
    render Rails.public_path.join("_eds","index.html"), layout: false
  end
end
