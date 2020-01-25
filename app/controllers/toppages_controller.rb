# frozen_string_literal: true

class ToppagesController < ApplicationController
  before_action :toppage_redirect, only: [:index]

  def index; end
end

private

def toppage_redirect
  redirect_to groups_url if logged_in?
end
