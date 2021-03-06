# frozen_string_literal: true
class Menu
  def initialize
    @trains = []
    @routes = []
  end

  def init
    choose_step
  end

  private

  def choose_step
    loop do
      display_menu
      user_choice = gets.to_i
      abort 'Good bye!' if user_choice.zero?
      check_user_input(user_choice)
    end
  end

  def display_menu
    puts <<~DISPLAY_MENU

        1) Create Station
        2) Create Train
        3) Create Route
        4) Manage Stations in Routes (Add/Remove)
        5) Assign Route to Train
        6) Add Carriage to Train
        7) Remove Carriage from Train
        8) Move Train Forward and Backwards by assigned Route
        9) Show List of Stations and Trains on the Stations
        10) Take Seat or fill Volume in Carriage
        0) QUIT
    DISPLAY_MENU
    print '=> '
  end

  def check_user_input(user_choice)
    case user_choice
    when 1
      create_station
    when 2
      create_train
    when 3
      create_route
    when 4
      manage_stations_in_route
    when 5
      assign_route_to_train
    when 6
      add_carriage_to_train
    when 7
      remove_carriage_from_train
    when 8
      move_train_by_route
    when 9
      print_stations_and_trains
    when 10
      take_seat_volume_carriage
    else
      display_menu
    end
  end

  def validation_error_message(e)
    puts "\n[ERROR] #{e}"
    puts 'Please, try again'
  end

  def create_station(title = '[CREATE] Please enter Station name to create:')
    user_input = characters_user_input(title)
    station = Station.new(user_input)
    puts "\n[SUCCESS] Station: #{station.name} created!"
  rescue StandardError => e
    validation_error_message(e)
    retry
  end

  def create_train(title = '[CREATE] Please choose Train type:')
    types = [CargoTrain, PassengerTrain]
    user_input = ordered_list_user_input(title, types)
    train_type = types[user_input - 1]

    title = 'Please enter Train number:'
    user_input_number = characters_user_input(title)

    train = train_type.new(user_input_number)
    @trains << train
    puts "\n[SUCCESS] #{train} created!"
  rescue StandardError => e
    validation_error_message(e)
    retry
  end

  def create_route
    if Station.all.size < 2
      puts
      puts 'For new Route you need at least 2 Stations.'
      puts "You have only #{Station.all.count}"

      title = 'Do you want to create Station?'
      custom_list = ['Yes, let\'s create Station',
                     'No, let\'s go to Main Menu']
      user_input = ordered_list_user_input(title, custom_list)
      case user_input
      when 1
        create_station
        create_route
      when 2
        display_menu
      end
    else
      create_route_core
    end
  end

  def create_route_core
    title = 'Please choose Route first Station:'
    user_input_first = ordered_list_user_input(title, Station.all)

    title = 'Please choose Route last Station:'
    user_input_last = ordered_list_user_input(title, Station.all)

    route = Route.new(Station.all[user_input_first - 1], Station.all[user_input_last - 1])
    @routes << route
    puts "\n[SUCCESS] #{route} created!"
  rescue StandardError => e
    validation_error_message(e)
    retry
  end

  def manage_stations_in_route
    if @routes.empty?
      puts
      puts 'You need at least 1 Route'
      puts "You have: #{@routes.count}"

      title = 'Do you want to create Route?'
      custom_list = ['Yes, let\'s create Route',
                     'No, let\'s go to Main Menu']
      user_input = ordered_list_user_input(title, custom_list)
      case user_input
      when 1
        create_route
        manage_stations_in_route
      when 2
        display_menu
      end
    else
      manage_stations_in_route_core
    end
  end

  def manage_stations_in_route_core
    title = 'Please choose Route in which you want Add/Remove Stations'
    user_input_route = ordered_list_user_input(title, @routes)
    user_route = @routes[user_input_route - 1]

    title = 'Please choose action:'
    options = ['Add station',
               'Remove station']
    user_input = ordered_list_user_input(title, options)
    case user_input
    when 1
      add_station_to_route(user_route)
    when 2
      remove_station_from_route(user_route)
    else
      manage_stations_in_route_core
    end
  end

  def add_station_to_route(route)
    available_stations = Station.all.select { |item| !route.stations.include?(item) }
    if available_stations.empty?
      puts "\nThere is no available Stations to Add to the Route"
      title = 'Do you want to create Station?'
      custom_list = ['Yes, let\'s create Station',
                     'No, let\'s go to Main Menu']
      user_input = ordered_list_user_input(title, custom_list)
      case user_input
      when 1
        create_station
        add_station_to_route(route)
      when 2
        display_menu
      end
    else
      title = 'Please choose Station to Add to Route'
      user_input_station = ordered_list_user_input(title, available_stations)
      user_station = available_stations[user_input_station - 1]
      route.add(user_station)
      puts "\n[SUCCESS] Station: #{user_station.name} added to the #{route}"
    end
  end

  def remove_station_from_route(route)
    available_stations = Station.all.select do |item|
      item != route.stations.first && item != route.stations.last
    end
    if available_stations.empty?
      puts "\nThere is no available Stations which you can Remove from Route"
      title = 'Do you want to add Station to Route?'
      custom_list = ['Yes, let\'s Add Station',
                     'No, let\'s go to Main Menu']
      user_input = ordered_list_user_input(title, custom_list)
      case user_input
      when 1
        add_station_to_route(route)
        manage_stations_in_route
      when 2
        display_menu
      end
    else
      title = 'Please choose Station to Remove from Route'
      user_input_station = ordered_list_user_input(title, available_stations)
      user_station = available_stations[user_input_station - 1]
      route.delete(user_station)
      puts "\n[SUCCESS] Station: #{user_station.name} removed from the #{route}"
    end
  end

  def assign_route_to_train
    if @trains.empty?
      puts
      puts 'For assigning Route to Train you need at least 1 Train'
      puts "You have: #{@trains.count} Trains"

      title = 'Do you want to create Train?'
      custom_list = ['Yes, let\'s create Train',
                     'No, let\'s go to Main Menu']
      user_input = ordered_list_user_input(title, custom_list)
      case user_input
      when 1
        create_train
        assign_route_to_train
      when 2
        display_menu
      end
    elsif @routes.empty?
      puts
      puts 'For assigning Route to Train you need at least 1 Route'
      puts "You have: #{@routes.count} Routes"

      title = 'Do you want to create Route?'
      custom_list = ['Yes, let\'s create Route',
                     'No, let\'s go to Main Menu']
      user_input = ordered_list_user_input(title, custom_list)
      case user_input
      when 1
        create_route
        assign_route_to_train
      when 2
        display_menu
      end
    else
      title = 'Please choose Train for assigning Route:'
      user_input = ordered_list_user_input(title, @trains)
      user_train = @trains[user_input - 1]

      title = 'Please choose Route for assignment to Train:'
      user_input = ordered_list_user_input(title, @routes)
      user_route = @routes[user_input - 1]

      user_train.route = user_route
      puts "\n[SUCCESS] #{user_train} Assigned to #{user_route}"
    end
  end

  def add_carriage_to_train
    if @trains.empty?
      puts
      puts 'For adding Carriage to Train you need at least 1 Train'
      puts "You have: #{@trains.count} Trains"

      title = 'Do you want to create Train?'
      custom_list = ['Yes, let\'s create Train',
                     'No, let\'s go to Main Menu']
      user_input = ordered_list_user_input(title, custom_list)
      case user_input
      when 1
        create_train
        add_carriage_to_train
      when 2
        display_menu
      end
    else
      title = 'Please choose Train for adding Carriage:'
      user_input = ordered_list_user_input(title, @trains)
      user_train = @trains[user_input - 1]
      add_carriage_to_train_core(user_train)
    end
  rescue StandardError => e
    validation_error_message(e)
    retry
  end

  def add_carriage_to_train_core(train)
    title = 'Please enter Carriage number:'
    user_input = characters_user_input(title)

    if train.is_a? CargoTrain
      title = 'Please enter Cargo Carriage maximum volume:'
      user_input_volume = characters_user_input(title).to_i
      carriage = CargoCarriage.new(user_input, user_input_volume)
    elsif train.is_a? PassengerTrain
      title = 'Please enter Carriage maximum number of seats:'
      user_input_volume = characters_user_input(title).to_i
      carriage = PassengerCarriage.new(user_input, user_input_volume)
    else
      puts 'ERROR'
    end

    train.add_carriage(carriage)
    print "\n[SUCCESS] #{carriage} was added to #{train}\n"
  end

  def remove_carriage_from_train
    if @trains.empty?
      puts
      puts 'For removing Carriage from Train you need at least 1 Train'
      puts "You have: #{@trains.count} Trains"

      title = 'Do you want to create Train?'
      custom_list = ['Yes, let\'s create Train',
                     'No, let\'s go to Main Menu']
      user_input = ordered_list_user_input(title, custom_list)
      case user_input
      when 1
        create_train
        remove_carriage_from_train
      when 2
        display_menu
      end
    else
      title = 'Please choose Train to remove Carriage:'
      user_input = ordered_list_user_input(title, @trains)
      user_train = @trains[user_input - 1]

      if user_train.carriages.empty?
        puts
        puts 'You need at least 1 Carriage at Train'
        puts "Train have: #{user_train.carriages.count} Carriages"

        title = 'Do you want to create Carriage?'
        custom_list = ['Yes, let\'s create Carriage',
                       'No, let\'s go to Main Menu']
        user_input = ordered_list_user_input(title, custom_list)
        case user_input
        when 1
          add_carriage_to_train
        when 2
          display_menu
        end
      else
        carriage = user_train.remove_carriage
        print "\n[SUCCESS] #{carriage} was removed from #{user_train}\n"
      end
    end
  end

  def move_train_by_route
    available_trains_on_route = @trains.select(&:route)
    if @trains.any?(&:route)
      title = 'Please choose Train on Route to move:'
      user_input = ordered_list_user_input(title, available_trains_on_route)
      user_train = @trains[user_input - 1]

      puts current_station = "\nCurrent Station: #{user_train.current_station.name}"
      unless user_train.next_station.nil?
        next_station = "Next Station: #{user_train.next_station.name}"
      end
      unless user_train.previous_station.nil?
        previous_station = "Previous Station: #{user_train.previous_station.name}"
      end
      title = 'Please Choose direction: '
      options = [next_station,
                 previous_station,
                 "Ok, let's go to Main Menu"].compact
      user_input = ordered_list_user_input(title, options)
      if user_input == 1
        user_train.move_next
        puts 'Train moves...'
        puts current_station
        move_train_by_route
      elsif user_input == 2 && options.count == 2
        display_menu
      elsif user_input == 2 && options.count == 3
        user_train.move_back
        puts 'Train moves...'
        puts current_station
        move_train_by_route
      else
        display_menu
      end
    else
      puts 'No Train on Route'
      assign_route_to_train
      move_train_by_route
    end
  end

  def characters_user_input(title)
    puts
    puts title
    puts '=' * title.length
    print '=> '
    gets.chomp
  end

  def ordered_list_user_input(title, items_array)
    puts
    puts title
    puts '=' * title.length
    items_array.each.with_index(1) { |item, i| puts "#{i}) #{item}" }
    print '=> '
    check_list_user_input(items_array)
  end

  def check_list_user_input(items_array)
    user_input = gets.to_i
    max_value = items_array.size
    if (1..max_value).cover?(user_input)
      user_input
    else
      puts "\nPlease enter number from 1 to #{max_value}"
      print '=> '
      check_list_user_input(items_array)
    end
  end

  def print_stations_and_trains
    puts 'Show all Stations'
    puts 'There are no Stations.' if Station.all.empty?
    Station.all.each do |station|
      puts "\nStation: #{station.name}\n--------\n"
      station.each_train do |train|
        puts train
        train.each_carriage { |carriage| puts carriage }
      end
    end
  end

  def take_seat_volume_carriage
    if @trains.empty?
      puts 'You have no Trains. Please add Train and then Carriage'
      add_carriage_to_train
    else
      title = 'Please choose Train:'
      user_input = ordered_list_user_input(title, @trains)
      user_train = @trains[user_input - 1]

      if user_train.carriages.empty?
        puts "\nThere is no Carriages in Train"
        title = 'Do you want to create Carriage?'
        custom_list = ['Yes, let\'s create Carriage',
                       'No, let\'s go to Main Menu']
        user_input = ordered_list_user_input(title, custom_list)
        case user_input
        when 1
          add_carriage_to_train_core(user_train)
        when 2
          display_menu
        end
      else
        title = 'Please choose Carriage:'
        user_input = ordered_list_user_input(title, user_train.carriages)
        user_carriage = user_train.carriages[user_input - 1]
        take_seat_volume_carriage_core(user_carriage)
      end
    end
  end

  def take_seat_volume_carriage_core(carriage)
    if carriage.is_a? CargoCarriage
      title = 'Please enter Volume to fill:'
      user_input = characters_user_input(title).to_i
      if carriage.take_volume(user_input)
        puts "\n[SUCCESS] Volume #{user_input} is filled"
      else
        puts 'There is no available volume'
      end
    elsif carriage.is_a? PassengerCarriage
      if carriage.take_seat
        puts "\n[SUCCESS] Seat is taken"
      else
        puts 'There is no available seats'
      end
    else
      puts 'ERROR'
    end
  end
end
