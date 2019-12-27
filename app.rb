require "sqlite3"
require_relative "shell"



class App
    # Открытие файла с базой данных, имя файла в кавычках
    DB = SQLite3::Database.new "database.db"
    SHELL = Shell.new

    def initialize
        # Создание таблицы станций, если её нету
        DB.execute "CREATE TABLE IF NOT EXISTS Stations(
            id INTEGER NOT NULL,
			code_esr6 UNSIGNED INTEGER,
            station_name VARCHAR(255),
            PRIMARY KEY(id)
        );"

        # Создание таблицы поездов, если её нету
        DB.execute "CREATE TABLE IF NOT EXISTS Trains(
            id INTEGER NOT NULL,
            idx VARCHAR(32),
            number INTEGER,
			forming_station INTEGER,
			destination_station INTEGER,
            time_departure TEXT,
            time_arrival TEXT,
            PRIMARY KEY(id),
            FOREIGN KEY(forming_station) REFERENCES Stations(id),
            FOREIGN KEY(destination_station) REFERENCES Stations(id)
        );"

        # Создание таблицы вагонов, если её нету
        DB.execute "CREATE TABLE IF NOT EXISTS Wagons(
            id INTEGER NOT NULL,
            cargo_name VARCHAR(255),
            cargo_destination VARCHAR,
            npp INTEGER,
            PRIMARY KEY(id),
            FOREIGN KEY(cargo_destination) REFERENCES Stations(id)
        );"
        
        SHELL.start
    end
end



App.new
