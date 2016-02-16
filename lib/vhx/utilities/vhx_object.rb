module Vhx
  class VhxObject
    include HelperMethods
    ASSOCIATION_WHITELIST = ['products', 'sites', 'site', 'videos', 'video', 'subscription', 'files', 'items', 'customer']

    def initialize(obj_hash)
      @obj_hash = obj_hash

      validate_class(obj_hash)
      create_readers(obj_hash)
      create_associations(obj_hash)
    end

    def to_json
      @obj_hash.to_json
    end

    def to_hash
      @obj_hash
    end

    def href
      @obj_hash['_links']['self']['href']
    end

    def links
      data = {}
      @obj_hash['_links'].each do |k, v|
        data[k] = v['href']
      end
      return OpenStruct.new(data)
    end

    def _links
      JSON.parse(@obj_hash['_links'].to_json, object_class: OpenStruct)
    end

  protected
    def validate_class(obj_hash)
      return nil unless obj_hash['_links'].fetch('self', nil)

      href  = obj_hash['_links']['self']['href']
      klass = self.class.to_s.split("::")
      klass.shift #strip out Vhx
      klass = klass.join("_").downcase

      is_valid_match = case klass
      when 'collection_item'
        href.match('video|file|collection')
      when 'video_file'
        href.match('file')
      else
        href.match(klass)
      end

      unless is_valid_match
        raise InvalidResourceError.new 'The resource returned from the API does not match the resource requested'
      end
    end

    def create_readers(obj_hash)
      obj_hash.keys.each do |key|
        next if key.match(/embedded|links/)
        self.class.send(:attr_reader, key)
        instance_variable_set("@#{key}", obj_hash[key])
      end
    end

    def create_associations(obj_hash)
      associations = (obj_hash.fetch('_links', {}).keys | obj_hash.fetch('_embedded', {}).keys).select{|k| ASSOCIATION_WHITELIST.include?(k)}
      associations.each do |association_method|
        self.class.send(:define_method, association_method) do |payload = {}|
          if payload.empty? && obj_hash['_embedded'] && obj_hash['_embedded'].fetch(association_method, []).length > 0
            return instance_variable_set("@#{association_method}", fetch_embedded_association(obj_hash, association_method))
          end

          if obj_hash['_links'] && obj_hash['_links'].fetch(association_method, []).length > 0
            return instance_variable_set("@#{association_method}", fetch_linked_association(obj_hash, association_method, payload))
          end

          raise InvalidResourceError.new 'Association does not exist'
        end
      end
    end

    def fetch_embedded_association(obj_hash, association_method)
      association_obj = obj_hash['_embedded'][association_method]
      build_association(association_obj, association_method)
    end

    def fetch_linked_association(obj_hash, association_method, payload = {})
      response = Vhx.connection.get do |req|
        req.url(obj_hash['_links'][association_method]['href'].gsub(Vhx.client.api_base_url, ""))
        req.body = payload
      end

      build_association(response.body, association_method)
    end

    def build_association(association_obj, association_method)
      # Support for legacy arrays, and new list objects starting with Video resource
      if association_obj.is_a?(Array) || association_obj.has_key?('total')
        return VhxListObject.new(association_obj, association_method)
      end

      Object.const_get("Vhx::#{association_method.gsub(/s\z/, '').capitalize}").new(association_obj)
    end
  end
end
