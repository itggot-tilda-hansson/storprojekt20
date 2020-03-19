require 'slim'
require 'sinatra'
require 'sqlite3'
require 'bcrypt'
require 'byebug'

enable :sessions

get("/") do 
    slim(:start)
end

db = SQLite3::Database.new("db/mello.db")
db.results_as_hash = true

post("/register") do
    username = params["username"]
    password = params["password"]
    password_confirmation = params["confirm_password"]

    # username = session[:id]

   p "här är params: #{params[0]}"
    
    
    result = db.execute("SELECT id FROM users WHERE username=?", username)
    
    p "result är #{result}"
    p "username är #{username}"

    p "password är #{password}"
    p "password_confirmation är #{password_confirmation}"

    # p password
    # p password_confirmation
    
    if result.empty?
        if password == password_confirmation
            password_digest = BCrypt::Password.create(password)
            p password_digest
            db.execute("INSERT INTO users(username, password_digest) VALUES (?,?)", [username, password_digest])
            id = db.execute("SELECT id FROM users WHERE username=?", username).first["id"]
            p id
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
    p session[:id]
    if session[:id] == nil
        p "hej"
        redirect('/error')
    else
        current_user = session[:id]
        note = db.execute("SELECT text FROM note WHERE user_id=?", current_user)
        p "note är #{note}"
        slim(:register_confirmation, locals:{list: note})
    end
end

post('/loggin') do
    username = params["username"]
    password = params["password"]

    result = db.execute("SELECT id, password_digest FROM users WHERE username=?", username)
    p result

    if result.empty? #ser om användaren finns
        # "användaren finns inte"
        p "användare"
        redirect('/error')
    else
        password_digest = result.first['password_digest']
        if BCrypt::Password.new(password_digest) == password #jämför med lösenordet i databasen
            #här loggar du faktiskt in
            session[:id] = result.first['id']
            p session[:id]
            session[:username] = username
            
            # session[:user_credentials] = {
                #     username: username
                #     id: id
                # }
                
            redirect('/register_confirmation')    
        else
            # om lösenorden inte stämmer
            p "lösenord"
            redirect('/error')
                
        end
    end

    # redirect('/register_confirmation')


end 

post('/logout') do
    p "logout"
    session[:id] = nil
    session[:username] = nil

    redirect('/')
end

get('/artister') do
    slim(:artister)

end

get('/topfem') do
    result = db.execute("SELECT name, artistid FROM artists")
    slim(:topfem, locals:{users: result})
end 

get('/all') do
    result = db.execute("SELECT * FROM artists WHERE winner IS NULL")
    p result
    slim(:all, locals:{users: result})
end

get('/all_win') do 
    result = db.execute("SELECT * FROM artists WHERE winner IS NOT NULL")
    # result = db.execute("SELECT artist FROM artists WHERE winner='true'")
    p result
    slim(:all_win, locals:{users: result})
end

get('/artists/:id') do 
    result = db.execute("SELECT * FROM artists WHERE artistid = ?", params[:id].to_i)
    slim(:album, locals:{result:result.first})
end

get('/artists/:id') do 
    result = db.execute("SELECT * FROM artists WHERE ArtistId = ?", params[:id].to_i)
    slim(:artists, locals:{result:result.first})
end

post('/artists') do
    id = params[:number]
    redirect("/artists/#{id}")
end

get('/dintopfem') do
    result = params.keys
    artistnamn = []
    # p result 

    result.each do |e|
        namn = db.execute("SELECT name FROM artists WHERE artistid = (?)", e.to_i)
        artistnamn << namn
    end
    p params
    p artistnamn
    slim(:dintopfem, locals:{result: artistnamn})
    # artistnamn = params[:artistnamn]
    # redirect("/dintopfem")

end 

get('/delete') do
    result = params.keys
    artistnamn = []

    result.each do |e|
        namn = db.execute("DELETE name FROM artists WHERE artistid = (?)", e.to_i)
        artistnamn << namn
    end
    p params
    p artistnamn
    slim(:dintopfem, locals:{result: artistnamn})

end

# post('/artists') do
#     id = params[:number]
#     redirect("/artists/#{id}")
# end



# post("/skapa_ny") do
#     text = params["item"]
#     db.execute("INSERT INTO note (text, user_id) VALUES (?,?)", [text, session[:id]])
#     redirect("/register_confirmation")
# end

# post("/delete") do 
#     db.execute("DELETE FROM note WHERE title=?", Title)
#     redirect("/register_confirmation")
# end