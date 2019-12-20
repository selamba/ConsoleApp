module Train
    def self.create(id, idx, number, forming, destination, departure, arrival)
        App::DB.execute "SELECT * FROM Trains WHERE id = #{id}" do |row|
            App::SHELL.msg("Дубликат: #{row}")
            return
        end
        App::DB.execute "INSERT INTO Trains (id, idx, number, forming_station, destination_station, time_departure, time_arrival)
        VALUES (#{id}, #{idx},  #{number}, \'#{forming}\', \'#{destination}\', \'#{departure}\', \'#{arrival}\');"
        App::SHELL.msg(Shell::Success_msg)
    end
end
