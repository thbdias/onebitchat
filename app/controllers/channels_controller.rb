class ChannelsController < ApplicationController
  before_action :set_channel, only: [:destroy, :show]
  
  def create
    # .new -> não salva no banco de dados, só cria o modelo
    @channel = Channel.new(channel_params)
    # authorize! -> verifique se o usuário current_user tem permissão de criar (:create) um channel (@channel) nesse time 
    authorize! :create, @channel

    respond_to do |format|
      # @team.save -> salvando no banco de dados, pq o .new não salvou anteriormente
      if @channel.save
        # :show -> view do jbuilder
        format.json { render :show, status: :created }
      else
        # status: :unprocessable_entity -> status 422
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize! :destroy, @channel
    @channel.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def show
    authorize! :read, @channel
  end


  private

  def set_channel
    @channel = Channel.find(params[:id])
  end

  def channel_params
    # filtra os parametros que vem da internet 
    # {channel: {slug: 'dsd', team_id: '5'}}
    # merge -> adicionando aos parâmetros permitidos (:slug, ...) o parâmetro 'user:' com o valor do current_user
    params.require(:channel).permit(:slug, :team_id).merge(user: current_user)
  end
end
