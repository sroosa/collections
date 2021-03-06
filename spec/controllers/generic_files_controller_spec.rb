require 'rails_helper'
require 'shared/doi_resource_behaviour'
require 'shared/nested_contributors_behaviour'

RSpec.describe GenericFilesController do
  routes { Sufia::Engine.routes }
  let(:user) { FactoryGirl.find_or_create(:user) }
  before { sign_in user }

  it_behaves_like "doi_resource_behaviour" do
    let(:resource_factory) { :generic_file }
  end

  it_behaves_like "nested_contributors_behaviour" do
    let(:resource) { FactoryGirl.create(:generic_file,:test_data,depositor: user) }
  end
  
  describe "permissions" do
    let!(:file) { FactoryGirl.create(:generic_file) }
    context "normal user" do
      let(:user) { FactoryGirl.create(:user) }
      it "cannot delete other user's files" do
        expect {
          delete :destroy, {id: file.to_param}
        }.not_to change(GenericFile, :count)
        expect(response).to redirect_to('/')
      end
    end
    context "admin user" do
      let(:user) { FactoryGirl.create(:admin_user) }
      it "can delete other user's files" do
        expect {
          delete :destroy, {id: file.to_param}
        }.to change(GenericFile, :count).by(-1)
      end
    end
  end

  describe "update" do
    let(:file) { FactoryGirl.create(:generic_file,:test_data,depositor: user) }

    describe "redirection" do
      context "when successful update" do
        it "redirects to show page" do
          post :update, id: file.id, generic_file: { title: ['My Favorite Things'] }
          expect(response).to redirect_to(generic_file_path(file))
        end

      end

      context "when invalid update" do
        # Controller doesn't yet actually enforce presence validation so
        # it's difficult to send any invalid parameters.
        xit "redirects to show page" do
          post :update, id: file.id, generic_file: { title: [] }
          expect(response).to redirect_to(edit_generic_file_path(file))
        end
      end
    end

    context "when adding a title" do
      let(:attributes) { { title: ['My Favorite Things'] } }
      before { post :update, id: file.id, generic_file: attributes }
      subject { file.reload.title }
      it { is_expected.to eq ["My Favorite Things"] }
    end

    context "when adding a contributor" do
      let(:attributes) {
        {
          contributors_attributes: [ { contributor_name: ['John'], affiliation: ['Coltrane'], role: ['http://id.loc.gov/vocabulary/relators/edt'], order: ["100"] } ]
        }
      }

      before { post :update, id: file.id, generic_file: attributes }
      subject { file.reload }

      it "sets the values using the parameters hash" do
        expect(subject.contributors_sorted.last.contributor_name).to eq ["John"]
        expect(subject.contributors_sorted.last.affiliation).to eq ["Coltrane"]
        expect(subject.contributors_sorted.last.role).to eq ["http://id.loc.gov/vocabulary/relators/edt"]
        expect(subject.contributors_sorted.last.order).to eq ['100']
      end
    end

    context "when removing a contributor" do
      let(:attributes) {
        {
          contributors_attributes: [ { id: file.contributors_sorted[1].id, _destroy: 1 } ]
        }
      }

      before {
        @deleted_contributor = file.contributors_sorted[1]
        @old_size = file.contributors.count
        post :update, id: file.id, generic_file: attributes
      }
      subject { file.reload }

      it "removes the contributor" do
        expect(subject.contributors.count).to eql(@old_size-1)
        expect(subject.contributors_sorted[1].contributor_name.first).not_to eql(@deleted_contributor.contributor_name.first)
      end
    end

    context "when reordering contributors" do
      let(:attributes) {
        {
          contributors_attributes: file.contributors.map do |c|
            { id: c.id, contributor_name: [c.contributor_name.first], affiliation: c.affiliation.to_a, role: [c.role.first], order: ["#{(c.order.first.to_i+1) % (file.contributors.count)}"]}
          end
        }
      }

      before {
        @old_contributors = file.contributors_sorted
        @old_size = file.contributors.count
        post :update, id: file.id, generic_file: attributes
      }
      subject { file.reload }

      it "sets the new ordering values" do
        expect(subject.contributors.count).to eql(@old_size)
        (0..(@old_size-1)).each do |i|
          expect(subject.contributors_sorted[i].to_hash).to eql(@old_contributors[(i+1) % (@old_size)].to_hash)
        end
      end
    end

  end
end
