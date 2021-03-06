module Sufia
  class CollectionPresenter
    include Hydra::Presenter
    include ActionView::Helpers::NumberHelper

    self.model_class = ::Collection
    # Terms is the list of fields displayed by app/views/collections/_show_descriptions.html.erb

    self.terms = [:resource_type, :title, :total_items, :size, :contributors,
                :funder, :abstract, :research_methods,
                :description, :tag, :subject, :based_near, :language,
                :related_url, :identifier,
                :publisher, :date_created ]

    # Depositor and permissions are not displayed in app/views/collections/_show_descriptions.html.erb
    # so don't include them in `terms'.
    # delegate :depositor, :permissions, to: :model

    def terms_with_values
      terms.select { |t| self[t].present? }
    end

    def [](key)
      case key
        when :size
          size
        when :total_items
          total_items
        else
          super
      end
    end

    def size
      number_to_human_size(model.bytes)
    end

    def total_items
      model.members.count
    end

  end
end
