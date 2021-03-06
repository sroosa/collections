class Contributor < ActiveFedora::Base
  include HydraDurham::PropertyWithRelevance
  type ::RDF::Vocab::DC.Agent

  belongs_to :contributorable, predicate: ::RDF::URI.new('http://collections.durham.ac.uk/ns#contributor_to'), class_name: 'ActiveFedora::Base'

  property :contributor_name, predicate: ::RDF::Vocab::FOAF.name do |index|
    index.as :stored_searchable
  end

  property_with_relevance :affiliation, predicate: ::RDF::URI.new('http://collections.durham.ac.uk/ns#contributor_affiliation') do |index|
    index.as :stored_searchable
  end

  property :role, predicate: ::RDF::URI.new('http://collections.durham.ac.uk/ns#contributor_role') do |index|
    index.as :stored_searchable
  end

  property :order, predicate: ::RDF::URI.new('http://collections.durham.ac.uk/ns#contributor_order') do |index|
    index.as :stored_searchable
  end

  def to_s
    string = ""
    string += contributor_name.any? { |string| string.strip.length > 0 } ? contributor_name.first + " " : ""
    string += affiliation.any? { |string| string.strip.length > 0 } ? "(" + affiliation.join('; ') + ")" : ""
    string.strip
  end

  def to_hash
    { contributor_name: contributor_name.to_a, affiliation: affiliation.to_a, role: role.to_a }
  end
end
