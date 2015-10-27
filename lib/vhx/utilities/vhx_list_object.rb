module Vhx
  class VhxListObject < Array

    def initialize(obj, list_type)
      @obj = obj

      if @obj.is_a?(Array)
        ar = @obj.map{|association_hash| Object.const_get("Vhx::#{list_type.gsub(/s\z/, '').capitalize}").new(association_hash)}
      elsif @obj.is_a?(Hash)
        @previous, @next = @obj['_links']['prev']['href'], @obj['_links']['next']['href']
        @total   = @obj['total']
        ar = @obj['_embedded'][list_type].map{|association_hash| Object.const_get("Vhx::#{list_type.gsub(/s\z/, '').capitalize}").new(association_hash)}
      end

      super(ar)
    end

    def previous
      @previous # TODO
    end

    def next
      @next # TODO
    end

    def total
      @total
    end

  end
end
