require 'net/http'
require 'open-uri'
require 'json'
require 'pry'

class Scrape_api

    attr_accessor :newss

  URL = "http://data.streetfoodapp.com/1.1/"
  @@api_list 

  def get_program                                   #gets the whole api
    uri = URI.parse(URL)
    response = Net::HTTP.get_response(uri)
    response.body                                   #gets the body of api
  end
  
  def make_dates                                             
        program = JSON.parse(self.get_program)      # use JSON library to parse the API response nicely
        program["open"].keys.each do |date|         #each key/date is 'date'
            Dates.create_from_api(date)             #each 'date' is now its own object
        end 
    end

    def make_locations
        newss = []
        program = JSON.parse(self.get_program)
        program["open"].keys.each do |x|            #goes into "open" key that contains hash with dates as keys
            
            program["open"]["#{x}"].map do |x|      #goes into each date and represents everything inside date as 'x'
                newss << x["region"]                #appends each 'region' value into variable
                
            end
            

        end
        newss.uniq.each do |region|                 #.uniq to get rid of repeats, .each to iterate to each element
            Locations.create_from_api(region)       #makes a Location instance with region value or 'region'
        end
    end

    def make_trucks
        newss = []
        program = JSON.parse(self.get_program)
        program["open"].keys.each do |x|
            program["open"]["#{x}"].each do |x|
                newss << x["name"]
            end
        end
        newss.uniq.each do |name|
            Trucks.create_from_api(name)
        end
        return nil
    end

    

    def self.api_list
        @@api_list = JSON.parse(self.new.get_program) #stores api hash in a class variable to give access to cli (Scrape_api::CLI.give_trucks)
    end

   

    

    
end



 