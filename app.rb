require "sqlite3"
require_relative "shell"



# Либо написать отдельно команды для каждой сущности,
# либо преобразовать введенный текст в sql

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
            idx VARCHAR(32),
            number INT,
            forming_station INT,
            destination_station INT,
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
