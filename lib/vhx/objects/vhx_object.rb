require 'active_support/core_ext/string/inflections'

module Vhx
  class VhxObject
    def initialize(obj_hash)
      @obj_hash = obj_hash
      create_accessors(@obj_hash)
      create_associations(@obj_hash)
    end

  protected

    def create_accessors(obj_hash)
      obj_hash.keys.each do |key|
        next if key.match(/embedded|links/)
        self.class.send(:attr_accessor, key)
        instance_variable_set("@#{key}", obj_hash[key])
      end
    end

    def create_associations(obj_hash)
      # obj_hash['_links'].keys.each do |key| # Need to fix gaps in API ['_links']
      ['packages', 'sites'].each do |association_class|
        self.class.send(:define_method, association_class) do

          if obj_hash['_embedded'] && obj_hash['_embedded'][association_class].length > 0
            return build_embedded_association(obj_hash, association_class)
          end

          fetch_linked_association(obj_hash)
        end
      end
    end

    def build_embedded_association(obj_hash, association_class)
      association_obj = obj_hash['_embedded'][association_class]

      case association_obj.class.to_s
      when 'Array'
        build_embedded_collection(association_obj, association_class)
      when 'Hash'
        build_embedded_object(association_obj, association_class)
      end
    end

    def build_embedded_collection(association_collection, association_class)
      association_collection.map{|association_hash| build_embedded_object(association_hash, association_class)}
    end

    def build_embedded_object(association_hash, association_class)
      Object.const_get("Vhx::#{association_class.singularize.capitalize}").new(association_hash)
    end

    def fetch_linked_association(obj_hash)
      puts "association needs to be fetched."
    end

  end
end
