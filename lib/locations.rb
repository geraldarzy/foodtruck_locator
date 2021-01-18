require 'pry'

class Locations

    attr_accessor :region

    @@all = []

    def initialize(region)
        @region = region

        save

    end

    def save
        self.class.all << self
    end

    def self.all
        @@all
    end

    def self.create_from_api(region)
        self.new(region)
    end
    def talk
        puts "Hello Arzy"
    end
    



end