# jbuilder é um construtor de json 

# json.extract! -> gera -> {id: 1, slug: 'dsd', ..., messages: [{}, {}, ...]} do channel
json.extract! channel, :id, :slug, :user_id, :team_id, :created_at, :updated_at

json.messages do
  json.array! channel.messages do |message|
    # json.extract! message -> gera -> {id: 1, slug: 'dsd', ..., messages: [{id: 1, body: 'bla bla bla', ...}, {id 2, ...}, ...]}
    # json.extract! message, :id, :body, :user_id, :created_at, :updated_at 
    
    json.extract! message, :id, :body, :user_id
    json.date message.created_at.strftime("%d/%m/%y")
    json.user do
      json.extract! message.user, :id, :name, :email
    end
  end
end