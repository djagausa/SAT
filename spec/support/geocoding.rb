module Geokit
  module Geocoders
    class MultiGeocoder < Geocoder
      def self.geocode(location)
        loc = GeoLoc.new
        loc.lat = 1
        loc.lng = 1
        loc.success = true
        loc
      end
    end
  end
end