class ApplicationController < ActionController::Base  
  protect_from_forgery with: :exception

  # executa o devise antes de todos os controllers
  before_action :authenticate_user!

  # checar todos controllers - cancancan
  include CanCan::ControllerAdditions

  # quando der exceção no cancancan
  # quando o usuário tentar acessar um lugar q não pode acessar
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, notice: exception.message }
    end
  end

end
