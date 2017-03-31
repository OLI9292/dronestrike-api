module AggregationUploadService
  class << self
    def call(source, data)
      data.map do |h|
        begin
          Dronestrike.create!(h)
        rescue Mongoid::Errors::Validations => e
          puts "AggregationUploadService -> Failed to create #{h[:name]}, #{h[:date]}\n\t#{e.summary}"
        end
      end
    end
  end
end
