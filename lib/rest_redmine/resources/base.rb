module RestRedmine
  module Resources
    class Base
      attr_accessor :data

      KEYS = []

      def initialize(keys=KEYS)
        @data = {}

        keys.each do |key|  
          @data[key] = nil
        end
      end

      def request(*args)
        RestRedmine::API.request(*args)
      end

      def method_missing(method, *args, &block)  
        if method.include? method
          data[method.to_sym]
        else
          super
        end
      end  
    end
  end
end