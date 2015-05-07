module Vhx
  module HelperMethods
    def get_klass
      if self.is_a?(Class)
        self.to_s.split("::").last
      else
        self.class.to_s.split("::").last
      end
    end

    def get_hypermedia(identifier, klass = nil)
      if identifier.class.to_s.match(/Integer|Fixnum/)
        klass ||= get_klass
        return '/' + klass.downcase + 's' + '/' + identifier.to_s #This url is based purely on VHX's API convention (not nested).
      end

      identifier
    end
  end
end