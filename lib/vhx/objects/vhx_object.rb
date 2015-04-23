module Vhx
  class VhxObject
    def initialize(response_json)
      create_accessors(response_json)
    end

  protected

    def create_accessors(response_json)
      response_json.keys.each do |key|
        next if key.match(/embedded|links/)
        self.class.send(:attr_accessor, key)
        instance_variable_set("@#{key}", response_json[key])
      end
    end
  end
end
