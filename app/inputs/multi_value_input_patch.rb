# Monkey patches hydra-editor app/inputs/multi_value_input.rb
# Actual patching is done in config/application.rb to_prepare callback
#
module MultiValueInputPatch

  def object_model
    if object.respond_to? :model
      object.model
    else
      object
    end
  end

  def field_readonly?(value=nil)
    object_model.try(:field_readonly?, attribute_name, value)
  end

  def field_warning?(value=nil)
    return false if field_readonly?(value)
    object_model.try(:doi_field_readonly?, attribute_name, value)
  end

  def input(wrapper_options)
    @rendered_first_element = false
    input_html_classes.unshift("string")
    input_html_options[:name] ||= "#{object_name}[#{attribute_name}][]"

    original_options=input_html_options.dup

    # remove last empty entry if the whole group is read only
    if field_readonly?
      collection # forces setting the instance variable
      @collection-=[''] if @collection.last == ''
    end

    outer_wrapper do
      buffer_each(collection) do |value, index|
        inner_wrapper(value,index) do
          input_html_options[:readonly]='readonly' if field_readonly? value
          ret=build_field(value, index)
          @input_html_options=original_options.dup
          ret
        end
      end
    end
  end

  protected
    def outer_wrapper
      readonly=''
      readonly+='readonly_field ' if field_readonly?
      readonly+='warning_field ' if field_warning?
      "    <ul class=\"listing #{readonly}\">\n        #{yield}\n      </ul>\n"
    end


    def inner_wrapper(value,index)
      readonly=''
      readonly+='readonly_field ' if field_readonly?(value)
      readonly+='warning_field ' if field_warning?(value)
      <<-HTML
        <li class="field-wrapper #{readonly}">
          #{yield}
        </li>
      HTML
    end

end
