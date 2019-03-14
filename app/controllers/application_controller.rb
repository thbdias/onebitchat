class ApplicationController < ActionController::Base  
  protect_from_forgery with: :exception

  # executa o devise antes de todos os controllers
  before_action :authenticate_user!

  # checar todos controllers - cancancan
  include CanCan::ControllerAdditions
end
