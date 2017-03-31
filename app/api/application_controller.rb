class ApplicationController < Sinatra::Base
  
  get '/' do  
    'Dronestrike API home.'
  end  

  get '/dronestrikes' do
    Dronestrike.all.to_json
  end
end
