module Vhx
  class VhxObject
    include HelperMethods
    ASSOCIATION_WHITELIST = ['packages', 'sites', 'site', 'videos']

    def initialize(obj_hash)
      @obj_hash = obj_hash

      validate_class(obj_hash)
      create_accessors(obj_hash)
      create_associations(obj_hash)
    end

    def to_json
      @obj_hash.to_json
    end

  protected
    def validate_class(obj_hash)
      unless obj_hash['_links']['self']['href'].match(self.class.to_s.split("::").last.downcase)
        raise InvalidResourceError.new 'The resource returned from the API does not match the resource requested'
      end
    end

    def create_accessors(obj_hash)
      obj_hash.keys.each do |key|
        next if key.match(/embedded|links/)
        self.class.send(:attr_accessor, key)
        instance_variable_set("@#{key}", obj_hash[key])
      end
    end

    def create_associations(obj_hash)
      (obj_hash['_links'].keys.select!{|k| ASSOCIATION_WHITELIST.include?(k)}).each do |association_method|
        instance_variable_set("@#{association_method}", nil)
        self.class.send(:define_method, association_method) do

          if instance_variable_get("@#{association_method}")
            return instance_variable_get("@#{association_method}")
          end

          if obj_hash['_embedded'] && obj_hash['_embedded'].fetch(association_method, []).length > 0
            return instance_variable_set("@#{association_method}", fetch_embedded_association(obj_hash, association_method))
          end

          if obj_hash['_links'] && obj_hash['_links'].fetch(association_method, []).length > 0
            return instance_variable_set("@#{association_method}", fetch_linked_association(obj_hash, association_method))
          end

          raise InvalidResourceError.new 'Association does not exist'
        end
      end
    end

    def fetch_embedded_association(obj_hash, association_method)
      association_obj = obj_hash['_embedded'][association_method]
      build_association(association_obj, association_method)
    end

    def fetch_linked_association(obj_hash, association_method)
      hypermedia = obj_hash['_links'][association_method]['href']
      response_json = Vhx.connection.get(hypermedia).body
      build_association(response_json, association_method)
    end

    def build_association(association_obj, association_method)
      # Support for legacy arrays, and new collection objects starting with Video resource
      if association_obj.is_a?(Array) || association_obj.has_key?('total')
        return VhxCollection.new(association_obj, association_method)
      end

      Object.const_get("Vhx::#{association_method.gsub(/s\z/, '').capitalize}").new(association_obj)
    end
  end
end
