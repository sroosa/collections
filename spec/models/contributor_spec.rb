require 'rails_helper'

RSpec.describe Contributor do
  let(:file) { FactoryGirl.create(:generic_file) }
  before {
    file.contributors.new( contributor_name: ['Test Contributor'], affiliation: ['Test Affiliation','Second Affiliation'], role: ['http://id.loc.gov/vocabulary/relators/cre'])
  }
  let(:contributor) { file.contributors.first }
  subject { contributor }

  it "should have a name" do
    expect(subject.contributor_name).to eql(['Test Contributor'])
  end
  it "should have an affiliation" do
    # match_array ignores ordering
    expect(subject.affiliation).to match_array(['Test Affiliation','Second Affiliation'])
  end
  it "should have a role" do
    expect(subject.role).to eql(['http://id.loc.gov/vocabulary/relators/cre'])
  end

  describe "persisting" do
    let(:contributor) {
      Contributor.create(contributor_name: ['Test Contributor'], affiliation: ['Test Affiliation','Second Affiliation'], role: ['http://id.loc.gov/vocabulary/relators/cre'], order: ['2'])
    }
    describe "loading from Solr" do
      let(:contributor_solr) { Contributor.load_instance_from_solr(contributor.id) }
      it "has correct attributes" do
        expect(contributor_solr.contributor_name).to eql ['Test Contributor']
        expect(contributor_solr.affiliation).to eql ['Test Affiliation','Second Affiliation']
        expect(contributor_solr.role).to eql ['http://id.loc.gov/vocabulary/relators/cre']
        expect(contributor_solr.order).to eql ['2']
      end
    end

    describe "loading from Fedora" do
      let(:contributor_fedora) { Contributor.find(contributor.id) }
      it "has correct attributes" do
        expect(contributor_fedora.contributor_name).to eql ['Test Contributor']
        expect(contributor_fedora.affiliation).to eql ['Test Affiliation','Second Affiliation']
        expect(contributor_fedora.role).to eql ['http://id.loc.gov/vocabulary/relators/cre']
        expect(contributor_fedora.order).to eql ['2']
      end
    end
  end

  describe "to_s" do
    subject { contributor.to_s }
    it "should include the name" do
      expect(subject.index(contributor.contributor_name.first)).to be_truthy
    end
    it "should include all the affiliations" do
      expect(subject.index('Test Affiliation')).to be_truthy
      expect(subject.index('Second Affiliation')).to be_truthy
    end
    it "should not include the role" do
      expect(subject.index('http://id.loc.gov/vocabulary/relators/cre')).to be_falsy
      expect(subject.index('creator')).to be_falsy
      expect(subject.index('Creator')).to be_falsy
    end
  end
end
