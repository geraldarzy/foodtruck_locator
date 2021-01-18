

class Trucks

    attr_accessor :name

    @@all = []

    def initialize(name)
        @name = name

        save

    end

    def save
        self.class.all << self
    end

    def self.all
        @@all
    end

    def self.create_from_api(name)
        self.new(name)
    end


end
