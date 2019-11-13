# For the documentation check http://sinatrarb.com/intro.html
class ApplicationController < Sinatra::Base
	  enable :sessions
	# This configuration part will inform the app where to search for the views and from where it will serve the static files
  	configure do
    	set :views, "app/views"
    	set :public_dir, "public"
  	end

		get '/' do
				@convertor = nil
		    erb :convertor , locals: {:error  =>  nil}
		end
	
		get '/convert/:id' do
					id = session[:id]
						@convertor = Convertor.find_by_id(id)
						if ( @convertor != nil )
						erb :convertor ,locals: {:error  => nil }
						else
						erb:convertor, locals: {:error  =>  "Not stored in Data base !! Serveur ERROR "}
					 	end

		end

		get '/history' do
				@convertor = Convertor.all
				@convertor = Convertor.all
				erb:history
		end
		
		post '/convert' do
  			if (params[:from].to_f != 0.0 )
				url = 'http://apilayer.net/api/live?access_key=f53d7a05738c3c2d637cbfe14d43cd10&currencies=USD,EUR,CHF&source=USD&format=1'
				uri = URI(url)
				response = Net::HTTP.get(uri)
				obj = JSON.parse(response)
				case params[:option]
				when 'USD/EUR'
					puts obj['quotes']['USDEUR'].to_f
					toFloat = ( 1.0 / obj['quotes']['USDEUR'].to_f) * params[:from].to_f 
					from = params[:from].to_s + ' ' + 'EUR'
					to = toFloat.to_s + '  ' + 'USD'
				when 'EUR/USD'
					toFloat = obj['quotes']['USDEUR'].to_f * params[:from].to_f 
					from = params[:from].to_s + ' ' + 'USD'
					to = toFloat.to_s + '  ' + 'EUR'
				when 'CHF/EUR'
					toFloat =( obj['quotes']['USDEUR'].to_f / obj['quotes']['USDCHF'].to_f ) * params[:from].to_f 
					from = params[:from].to_s + ' ' + 'CHF'
					to = toFloat.to_s + '  ' + 'EUR'
				when 'EUR/CHF'
					toFloat = ( obj['quotes']['USDCHF'].to_f / obj['quotes']['USDEUR'].to_f ) * params[:from].to_f 
					from = params[:from].to_s + ' ' + 'EUR'
					to = toFloat.to_s + '  ' + 'CHF'
				else
					redirect to "/"
				end 
				@convertor = Convertor.new(from: from , to: to, typeConvertor: params[:option] )
					if @convertor.save
						session[:id] = @convertor.id
						redirect to "/convert/#{@convertor.id}"
					end
				else 
					@convertor = nil
					erb:convertor, locals: {:error  =>  "Please enter a valid amount"}
				end
		end 

 
end

