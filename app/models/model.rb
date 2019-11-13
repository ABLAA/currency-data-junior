# this is a simple model example
# check https://datamapper.org/getting-started.html

class Convertor

	include DataMapper::Resource

	property :id,      Serial    
	property :from,    String    
	property :to,      String 
	property :typeConvertor, String

	def self.find_by_id(id)
 	Convertor.all.detect {|x| id == x.id}
    end
end

DataMapper.finalize
DataMapper.auto_upgrade!

