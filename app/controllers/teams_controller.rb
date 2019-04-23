class TeamsController < ApplicationController
  before_action :set_team, only: [:destroy]
  before_action :set_by_slug_team, only: [:show]

  def index
    @teams = current_user.teams
  end

  def show
    # authorize! -> verifique se o usuário current_user tem permissão de leitura (:read) nesse record (@team)
    authorize! :read, @team
  end

  def create
    # .new -> não salva no banco de dados, só cria o modelo
    @team = Team.new(team_params)

    respond_to do |format|
      # @team.save -> salvando no banco de dados, pq o .new não salvou anteriormente
      if @team.save
        format.html { redirect_to "/#{@team.slug}" }
      else
        format.html { redirect_to main_app.root_url, notice: @team.errors }
      end
    end
  end

  def destroy
    authorize! :destroy, @team
    @team.destroy

    respond_to do |format|
      format.json { head :no_content }
      format.html { redirect_to main_app.root_url, notice: 'Tea deleted' }
    end
  end


  private

  def set_by_slug_team
    @team = Team.find_by(slug: params[:slug])
  end

  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    # filtra os parametros que vem da internet 
    # {team: {slug: 'dsd'}}
    # merge -> adicionando aos parâmetros permitidos (:slug, ...) o parâmetro 'user:' com o valor do current_user
    params.require(:team).permit(:slug).merge(user: current_user)
  end
end
