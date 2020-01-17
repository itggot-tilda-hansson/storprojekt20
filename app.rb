require 'slim'
require 'sinatra'
require 'sqlite3'
require 'bcrypt'

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

   
    
    
    result = db.execute("SELECT id FROM users WHERE username=?", username)
    
    if result.empty?
        if password == password_confirmation
            password_digest = BCrypt::Password.create(password)
            p password_digest
            db.execute("INSERT INTO users(username, password_digest) VALUES (?,?)", [username, password_digest])
            id = db.execute("SELECT id FROM users WHERE username=?", username).first["id"]
            p id
            session[:id] = id
            
        end
    end
    
    
    redirect('/register_confirmation')
end


get("/register_confirmation") do
    db = SQLite3::Database.new("db/mello.db")
    db.results_as_hash = true
    current_user = session[:id]
    note = db.execute("SELECT text FROM note WHERE user_id=?", current_user.to_i)
    p "note är #{note}"
    slim(:register_confirmation, locals:{list: note})
end

# post("/skapa_ny") do
#     text = params["item"]
#     db.execute("INSERT INTO note (text, user_id) VALUES (?,?)", [text, session[:id]])
#     redirect("/register_confirmation")
# end

# post("/delete") do 
#     db.execute("DELETE FROM note WHERE title=?", Title)
#     redirect("/register_confirmation")
# end