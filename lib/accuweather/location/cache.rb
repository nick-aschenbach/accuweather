module Accuweather
  module Location
    class Cache
      CITIES_CSV_FILE = File.join(File.dirname(__dir__), '..', '..', 'assets', 'cities.z')

      def initialize
        csv_data = Zlib::Inflate.inflate(File.read(CITIES_CSV_FILE))

        @city_data = {}
        csv_data.split("\n").each do |line|
          line_data = line.split('|')
          arr = @city_data[line_data[1].downcase]
          arr = [] if arr.nil?
          arr << Accuweather::Location::City.new(id: line_data[0],
                                                 city: line_data[1],
                                                 state: line_data[2],
                                                 latitude: line_data[3],
                                                 longitude: line_data[4])
          @city_data[line_data[1].downcase] = arr
        end
      end

      def cities(name:)
        @city_data.fetch(name.downcase, [])
      end
    end
  end
end