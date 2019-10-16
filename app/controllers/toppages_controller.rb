class ToppagesController < ApplicationController
  before_action :toppage_redirect, only: [:index]
  
  def index
  end
end

private

    def toppage_redirect
        if logged_in?
          redirect_to groups_url
        end
    end