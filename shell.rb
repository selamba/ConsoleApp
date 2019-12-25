require_relative "commands"



class Shell
    Clear_screen = "clear"  # Команда очистки экрана
    Success_msg = "Операция успешно выполнена."
    @@command_history = []  # История введённых команд
    Entity_commands = [     # Список корректных команд
        "create",
        "select",
        "update",
        "delete",
        "generate"
    ]
    
            
    # Главный цикл
    def start
        # Очистка экрана
        system(Clear_screen)
        
        # Сам цикл
        loop do
            print(">> ")
            input = gets.chomp
            
            # Поддержание истории введённых команд
            # TODO: взаимодействие с историей
            @@command_history.push(input)
            if @@command_history.length > 32
                @@command_history.delete_at(0)
            end
            

            # Обработка ввода
            if input == "exit"
                system(Clear_screen)
                return
            end
			input_words = input.split(" ")
            
            # Обработка целевой таблицы
            target_table = ""
            case input_words[0]
            when "train"
                target_table = "Trains"
            when "station"
                target_table = "Stations"
            when "wagon"
                target_table = "Wagons"
            else
                self.msg("Неверная сущность: #{input_words[0]}")
                next
            end
            
            # Обработка целевой команды
            target_command = input_words[1]
            if !Entity_commands.include?(target_command)
                self.msg("Неверная команда: #{target_command}")
                next
            end
            
            # Самое интересное
            if target_table == "Trains"
                case target_command
                when "create"
                    Train::Create.call input, input_words
                when "select"
                    Train::Select.call input, input_words
                when "update"
                    Train::Update.call input, input_words
                when "delete"
                    Train::Delete.call input, input_words
                when "generate"
                    Train::Generate.call input, input_words
                end
            elsif target_table == "Stations"
                case target_command
                when "create"
                    Station::Create.call input, input_words
                when "select"
                    Station::Select.call input, input_words
                when "update"
                    Station::Update.call input, input_words
                when "delete"
                    Station::Delete.call input, input_words
                when "generate"
                    Station::Generate.call input, input_words
                end
            elsif target_table == "Wagons"
                case target_command
                when "create"
                    Wagon::Create.call input, input_words
                when "select"
                    Wagon::Select.call input, input_words
                when "update"
                    Wagon::Update.call input, input_words
                when "delete"
                    Wagon::Delete.call input, input_words
                when "generate"
                    Wagon::Generate.call input, input_words
                end
            end
        end
    end
    
    # Вывод msg на экран
    def msg(msg, newline = true)
        print(msg)
        puts() if newline
    end
end
