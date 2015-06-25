module HydraDurham
  module FormAuthorOverrides
    extend ActiveSupport::Concern

    module ClassMethods
      def build_permitted_params
        permitted = super
        permitted.delete({ authors: [] })
        permitted << { authors_attributes: permitted_authors_params }
        permitted
      end

      protected
        def permitted_authors_params
          [
            :id,
            :_destroy,
            {
              author_name: [],
              affiliation: []
            }
          ]
        end
    end # ClassMethods

    protected

      # Override HydraEditor::Form to treat nested attributes accordingly
      def initialize_field(key)
        if reflection = model_class.reflect_on_association(key)
          raise ArgumentError, "Association ''#{key}'' is not a collection" unless reflection.collection?
          build_association(key)
        else
          super
        end
      end

    private

      def build_association(key)
        association = model.send(key)
        if association.empty?
          self[key] = Array(association.build)
        else
          association.build
          self[key] = association
        end
      end

  end
end