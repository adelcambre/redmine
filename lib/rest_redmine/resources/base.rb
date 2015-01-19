module RestRedmine
  module Resources
    class Base
      attr_accessor :model, :id, :name

      KEYS = []
      DEFAULT_MODEL = {}

      def initialize(params={})
        @model = {}
        @name = self.class.to_s.split("::").last.downcase.to_sym
        
        self.class::KEYS.each do |key|  
          @model[key] = nil
        end

        @model.merge!(self.class::DEFAULT_MODEL)
        params.merge!(RestRedmine.configuration.resources[@name] || {})
        @model.merge!(params)

        self.id = params[:id] if params[:id]
      end

      def load
        raise RestRedmine::Exception.new("Id is required") unless self.id
        response = request(method: :get)
      end

      def save
        method = self.id ? :put : :post

        request(method: method)
      end

      def request(method: :get)
        response = RestRedmine::API.request(self.class::RESOURCE, id: self.id, data: get_data, method: method)

        self.id = response[name.to_s]["id"] if response.respond_to? :has_key?
        # puts response
        
        # response[name.to_s].each do |key, val|
        #   if model.has_key? key.to_sym
        #     @model[key.to_sym] = val
        #   elsif model.has_key? "#{key}_id".to_sym
        #     @model["#{key}_id".to_sym] = val["id"]
        #   elsif key == "id"
        #     self.id = val
        #   end
        # end 

        response
      end

      def get_data
        {
          "#{name}" => model
        }
      end

      def method_missing(method, *args, &block)  
        if self.class::KEYS.include? method
          @model[method.to_sym]
        elsif method.to_s =~ /=$/ and self.class::KEYS.include? method.to_s.sub("=", "").to_sym
          @model[method.to_s.sub("=", "").to_sym] = args.first
        else
          super
        end
      end  
    end
  end
end