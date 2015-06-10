class Author < ActiveFedora::Base
  type ::RDF::DC.Agent

  has_many :generic_files, inverse_of: :authors, class_name: "GenericFile"

  property :author_name, predicate: ::RDF::FOAF.name do |index|
    index.as :stored_searchable
  end

  property :affiliation, predicate: ::RDF::FOAF.currentProject do |index|
    index.as :stored_searchable
  end

  def to_s
  	string = ""
  	string += author_name.any? { |string| string.strip.length > 0 } ? author_name.first + " " : ""
  	string += affiliation.any? { |string| string.strip.length > 0 } ? "(" + affiliation.first + ")" : ""
  	string.strip
  end
end