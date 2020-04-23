require 'slim'
require 'sinatra'
require 'sqlite3'
require 'bcrypt'
require 'byebug'

require_relative 'model.rb'

enable :sessions

include Model


before do
    path = request.path_info
    list = ['/', '/register', '/error', '/register_confirmation', '/loggin', '/logout', '/artister', '/favorite_artist', '/all', '/all_win', '/artists/:id', '/artists', '/your_favorite_artist', '/delete']
    redirect = true
    
    list.each do |e|
        if path == e
            redirect = false
        end
    end

    if session[:id].nil? and redirect
        redirect('/')
    end
end


get("/") do
    # session[:id] = nil
    # session[:username] = nil
    slim(:start)
end

post("/register") do
    username = params["username"]
    password = params["password"]
    password_confirmation = params["confirm_password"]
    
    result = id_from_username(username)
    
    if result.empty?
        if password == password_confirmation
            password_digest = BCrypt::Password.create(password)
            id = id_from_users(username)
            session[:id] = id
            session[:username] = username
            redirect('/register_confirmation')
        else
            session[:error] = "Lösenordet är nog fel"
            redirect('/error')
        end
    else
        set_error("Användarnamnet finns redan :(")
        redirect('/error')
    end
end

get("/error") do
    slim(:error)

end

get("/register_confirmation") do    

    if session[:id] == nil

        redirect('/error')
    else
        current_user = session[:id]
        note = text_from_note(current_user)
        slim(:register_confirmation, locals:{list: note})
    end
end

post('/loggin') do
    username = params["username"]
    password = params["password"]

    result = id_from_users(username)

    if result.empty? #ser om användaren finns
        # "användaren finns inte"
        redirect('/error')
    else
        password_digest = result.first['password_digest']
        if BCrypt::Password.new(password_digest) == password #jämför med lösenordet i databasen
            #här loggar du faktiskt in
            session[:id] = result.first['id']
            session[:username] = username
                
            redirect('/register_confirmation')    
        else
            redirect('/error')
                
        end
    end

    # redirect('/register_confirmation')


end 

post('/logout') do
    session[:id] = nil
    session[:username] = nil
    redirect('/')
end

get('/artister') do
    slim(:artister)

end

get('/favorite_artist') do
    result = name_from_artists
    slim(:favorite_artist, locals:{users: result})
end 

get('/all') do
    result = all_from_artists
    slim(:all, locals:{users: result})
end

get('/all_win') do 
    result = all_win_from_artists
    slim(:all_win, locals:{users: result})
end

get('/artists/:id') do 
    result = all_from_artistid

    if result.empty?
        redirect('/error')
    end
        
    slim(:album, locals:{result:result.first})
end

post('/artists') do
    id = params[:number]
    redirect("/artists/#{id}")
end

get('/your_favorite_artist') do
    result = params.keys
    artistnamn = []

    result.each do |e|
        namn = db.execute("SELECT name FROM artists WHERE artistid = (?)", e.to_i)
        # name = name_from_artists
        artistnamn << namn
    end
    slim(:your_favorite_artist, locals:{result: artistnamn})
end 

get('/delete') do
    result = params.keys
    artistnamn = []

    result.each do |e|
        namn = db.execute("DELETE name FROM artists WHERE artistid = (?)", e.to_i)
        artistnamn << namn
    end
    slim(:your_favorite_artist, locals:{result: artistnamn})
    

end
