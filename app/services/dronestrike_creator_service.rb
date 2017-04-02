module DronestrikeCreatorService
  class << self
    def call(source, data)
      country = country_from_source source
      data.each {|strike| create_dronestrike(strike, country) }
    end

    private

    def countries
      %w(afghanistan pakistan somalia yemen)
    end

    def country_from_source(source)
      countries.find { |country| source.include? country }
    end

    def create_dronestrike(strike, country)
      begin
        location = "#{country}, #{strike.delete(:location)}"
        geocoded = geocode location
        dronestrike = Dronestrike.create(strike)
        if geocoded
          geocoded[:dronestrike] = dronestrike
          dronestrike.location = Location.create(geocoded)
          puts "DronestrikeCreatorService -> Successfully geocoded #{strike[:name]}, #{geocoded[:address]}"
        else
          puts "DronestrikeCreatorService -> Failed to geocode #{strike[:name]}, #{location}"
        end
        dronestrike.save!
      rescue Mongoid::Errors::Validations => e
        puts "DronestrikeCreatorService -> Failed to create #{strike[:name]}, #{strike[:date]}\n\t#{e.summary}"
      end
    end

    def geocode(location)
      result = Geocoder.search(location).first
      {
        content: location,
        latitude: result.latitude,
        longitude: result.longitude,
        address: result.address,
        city: result.city,
        state: result.state,
        state_code: result.state_code,
        country: result.country,
        country_code: result.country_code,
        postal_code: result.postal_code
      } if result
    end
  end
end
