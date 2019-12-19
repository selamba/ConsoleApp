

class Shell
    Ruby_command = "ruby"   # Команда для вызова интерпретатора
    Clear_screen = "clear"  # Команда очистки экрана
    @@command_history = []  # История введённых команд
    
    
    # Главный цикл
    def start
        # Очистка экрана
        system(Clear_screen)
        
        # Сам цикл
        loop do
            print (">> ")
            input = gets.chomp
            @@command_history.push(input)
        
            case input
            when "exit"
                # Очистка экрана
                system(Clear_screen)
                break
            when "station create"
                system(Ruby_command, "./DBCommands/station/create.rb")
                puts(App::DB)
            else
                puts("Неизвестная команда: #{input}")
                puts("Напишите \"help\" для помощи.")
            end
        end
    end
end
