

class Gossip
  attr_accessor :author, :content
  def initialize(author,content)
    @author = author
    @content = content
  end

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end
  def self.all
  	all_gossips = [] #on initialise un array vide
	 	CSV.read("./db/gossip.csv").each do |line|
		 	all_gossips << Gossip.new(line[0],line[1])
		end

 		return all_gossips
	end
  def self.find(id)
		return Gossip.all[id]
	end
	#sauvegarde en memoire la modification du gossip (en sauvegardant sa position dans le fichier csv)
	def self.update(author, content, id)
		gossip_array = self.all
		gossip_array[id.to_i].content = content
		gossip_array[id.to_i].author = author
		#erase the csv file
		File.open("./db/gossip.csv", 'w') {|file| file.truncate(0) }
		#rewrite the file with the modif
		gossip_array.each do |gossip|
			gossip.save
		end	
	end
end
