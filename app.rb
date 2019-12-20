require "sqlite3"
require_relative "shell"



class App
    # Открытие файла с базой данных, имя файла в кавычках
    DB = SQLite3::Database.new "database.db"
    SHELL = Shell.new

    def initialize
        # Создание таблицы станций, если её нету
        DB.execute "CREATE TABLE IF NOT EXISTS Stations(
            id INT,
            code_esr6 UNSIGNED INT,
            station_name VARCHAR(255),
            PRIMARY KEY(id)
        );"

        # Создание таблицы поездов, если её нету
        DB.execute "CREATE TABLE IF NOT EXISTS Trains(
            id INT,
            idx INT,
            number INT,
            forming_station VARCHAR(255),
            destination_station VARCHAR(255),
            time_departure TEXT,
            time_arrival TEXT,
            PRIMARY KEY(id),
            FOREIGN KEY(forming_station) REFERENCES Stations(id),
            FOREIGN KEY(destination_station) REFERENCES Stations(id)
        );"

        # Создание таблицы вагонов, если её нету
        DB.execute "CREATE TABLE IF NOT EXISTS Wagons(
            id INT,
            cargo_name VARCHAR(255),
            cargo_destination VARCHAR,
            npp INT,
            PRIMARY KEY(id),
            FOREIGN KEY(cargo_destination) REFERENCES Stations(id)
        );"
        
        SHELL.start
    end
end



App.new
