class Scrape_api::CLI

    attr_accessor :date, :location

    def call
        puts "Hello! Welcome to the FoodTruck Locator."
        menu
    end

    def menu # print a list of dates to choose from, usr chooses date
        puts "To determine the foodtrucks in your desired area, please begin by choosing a location."
        puts "Here is a list of locations."
        puts Locations.all.map{|i|i.region}
        puts "Please choose one."
        get_location        #get a VALID location from usr
        get_date            #get a VALID date from usr
        give_trucks         #give usr list of trucks that will be at location and date of usr inputs
        ask_again           #after all is done, program asks if the usr wants more info or to quit

    
    end

    def get_location        
        @location = gets.strip.to_str                               #@location stores the input of the user
        if !Locations.all.map{|i|i.region}.include?(@location)      #this makes sure usr input is in the list of locations
            puts "Selection not valid, please choose a valid location"
            get_location
        else
            puts "You chose #{@location}. Now here is a list of dates."

        end


    end

    def get_date
        puts Dates.all.map{|i|i.date}
        puts "Please choose one."
        @date = gets.strip.to_str                       #stores usr input in @date
        if !Dates.all.map{|i|i.date}.include? @date     #checks to see if @date is in dates list
            puts "Selection not valid, please choose a valid date"
            get_date
        else
            puts "You chose #{@date}."
            puts ""

        end


    end

    def give_trucks
        trucks = []
        program = Scrape_api.api_list
        program["open"]["#{@date}"].map do |x|
            if x["region"] == @location.to_str
                trucks << x["name"]
            end
        end
        if trucks.size > 0
            puts "Okay great! Here is a list of foodtrucks that will be at #{@location} on #{@date}. "
            puts "#{trucks.join(", ")}"
        else
            puts "There are no foodtrucks in #{@location} at #{@date}"
        end
    end

    def ask_again
        puts "____________________________________________________________________"
        puts ""
        puts "Would you like to get more information about another place and date?"
        puts "Yes or No?"
        input = gets.strip.to_str
        if input == "Yes" || input == "yes" || input == "Y" || input == "y"         #if input is yes start from top
            menu
        elsif input == "No" || input == "no" || input == "N" || input == "n"        #if input is no, goodbye msg
            puts ""
            puts "Thank you for using FoodTruck Locator. Goodbye!"
        else 
            puts "Invalid choice, please try again"                                 #checks if input is valid
            ask_again
        end
    end

end