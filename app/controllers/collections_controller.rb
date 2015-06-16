class CollectionsController < ApplicationController
	include Sufia::CollectionsControllerBehavior

    def collection_params
      form_class.model_attributes(
        params.require(:collection).permit(:title, :description, :members, part_of: [],
          contributor: [], creator: [], publisher: [], date_created: [], subject: [],
          language: [], rights: [], resource_type: [], identifier: [], based_near: [],
          tag: [], related_url: [], funder: [], abstract: [], research_methods: [])
      )
    end

  after_filter :update_datacite, only: [ :update ]
  after_filter :destroy_datacite, only: [ :destroy ]

  def update_datacite
    if @collection.manage_datacite?
      datacite = Datacite.new
      datacite.metadata(@collection.doi_metadata_xml)
    end
  end

  def destroy_datacite
    # TODO: Need to decide what happens here. Presumably something gets
    #       sent to datacite, but also need a gravestone here.
  end
end
