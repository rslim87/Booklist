class Topic < ActiveRecord::Base
	belongs_to :book

	def slug
		self.name.downcase.gsub(' ','-').gsub('/','-')
	end

	def self.find_by_slug(slug)
		Genre.all.find {|genre| genre.slug == slug}
	end
end
