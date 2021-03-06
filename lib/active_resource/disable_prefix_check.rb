module DisablePrefixCheck
  extend ActiveSupport::Concern

  module ClassMethods
    def check_prefix_options(options)
    end

    # `flexible = true` is hack to allow multiple things through the same AR class
    def conditional_prefix(resource, flexible = false)
      resource_id = "#{resource}_id".to_sym
      resource_type = flexible ? ":#{resource}" : resource.to_s.pluralize

      init_prefix_explicit resource_type, resource_id

      define_singleton_method :prefix do |options|
        resource_type =  options[resource] if flexible

        options[resource_id].nil? ? "/admin/" : "/admin/#{resource_type}/#{options[resource_id]}/"
      end
    end
  end
end
