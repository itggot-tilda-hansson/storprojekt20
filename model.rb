module Model
    
    def db()
        db = SQLite3::Database.new('db/mello.db')
        db.results_as_hash = true

        return db
    end

    def id_from_username(username)
        db = db()
        result =  db.execute("SELECT id FROM users WHERE username=?", username)
        return result

    end

    def id_from_users(username)
        db = db()
        db.execute("INSERT INTO users(username, password_digest) VALUES (?,?)", [username, password_digest])
        id = db.execute("SELECT id FROM users WHERE username=?", username).first["id"]
        return id

    end

    def text_from_note(current_user)
        db = db()
        note = db.execute("SELECT text FROM note WHERE user_id=?", current_user)
        return note
    end

    def id_from_users(username)
        db = db()
        result = db.execute("SELECT id, password_digest FROM users WHERE username=?", username)
        return result
    end

    def name_from_artists()
        db = db()
        result = db.execute("SELECT name, artistid FROM artists")
        return result
    end

    def all_from_artists()
        db = db()
        result = db.execute("SELECT * FROM artists WHERE winner IS NULL")
        return result
    end

    def all_win_from_artists()
        db = db()
        result = db.execute("SELECT * FROM artists WHERE winner IS NOT NULL")
        return result
    end

    def all_from_artistid()
        db = db()
        result = db.execute("SELECT * FROM artists WHERE artistid = ?", params[:id].to_i)
        return result
    end

end

# def name_from_artists()
#     db = db()
#     namn = db.execute("SELECT name FROM artists WHERE artistid = (?)", e.to_i)
#     return name
# end








    


    

