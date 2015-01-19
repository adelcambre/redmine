module RestRedmine
  module Resources
    class Base
      attr_accessor :data

      KEYS = []

      def initialize()
        KEYS.each do |key|  
          data[key] = nil
        end
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