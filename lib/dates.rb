require 'pry'
class Dates

    attr_accessor :date

    @@all = []

    def initialize(date)
        @date = date
        save #saves all dates into @@all list

    end

    def save
        self.class.all << self
    end

    def self.all
        @@all
    end

    def self.create_from_api(date) #instantiates a new instance with data from api hash
        self.new(date)
    end

    def talk
        puts "Hello Arzy"
    end

    def locations           #a date has many locations
        Locations.all
    end

end



