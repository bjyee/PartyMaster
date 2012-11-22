class Location < ActiveRecord::Base

	belongs_to :host
	has_many :parties, :dependent => :destroy
	
	STATES_LIST = [['Alabama', 'AL'],['Alaska', 'AK'],['Arizona', 'AZ'],['Arkansas', 'AR'],['California', 'CA'],['Colorado', 'CO'],['Connectict', 'CT'],['Delaware', 'DE'],['District of Columbia ', 'DC'],['Florida', 'FL'],['Georgia', 'GA'],['Hawaii', 'HI'],['Idaho', 'ID'],['Illinois', 'IL'],['Indiana', 'IN'],['Iowa', 'IA'],['Kansas', 'KS'],['Kentucky', 'KY'],['Louisiana', 'LA'],['Maine', 'ME'],['Maryland', 'MD'],['Massachusetts', 'MA'],['Michigan', 'MI'],['Minnesota', 'MN'],['Mississippi', 'MS'],['Missouri', 'MO'],['Montana', 'MT'],['Nebraska', 'NE'],['Nevada', 'NV'],['New Hampshire', 'NH'],['New Jersey', 'NJ'],['New Mexico', 'NM'],['New York', 'NY'],['North Carolina','NC'],['North Dakota', 'ND'],['Ohio', 'OH'],['Oklahoma', 'OK'],['Oregon', 'OR'],['Pennsylvania', 'PA'],['Rhode Island', 'RI'],['South Carolina', 'SC'],['South Dakota', 'SD'],['Tennessee', 'TN'],['Texas', 'TX'],['Utah', 'UT'],['Vermont', 'VT'],['Virginia', 'VA'],['Washington', 'WA'],['West Virginia', 'WV'],['Wisconsin ', 'WI'],['Wyoming', 'WY']]

	scope :all, order('name')
	scope :for_host, lambda {|host_id| where('host_id = ?', host_id) }
	
	before_save :find_house_coordinates
	
	def create_map_link(zoom=14,width=800,height=800)
		marker = "&markers=color:red%7Ccolor:red%7Clabel:1%7C#{latitude},#{longitude}"
		map = "http://maps.google.com/maps/api/staticmap?center=#{latitude},#{longitude}&zoom=#{zoom}&size=#{width}x#{height}&maptype=#{marker}&sensor=false"
	end
	
	private
	
	def find_house_coordinates
      str = self.street
      town = self.city
      st = self.state
      coord = Geokit::Geocoders::GoogleGeocoder.geocode "#{str}, #{town}, #{st}"
      if coord.success
  	    self.latitude, self.longitude = coord.ll.split(',')
  	  else 
  	    errors.add_to_base("Error with geocoding")
  	  end
    end
end
