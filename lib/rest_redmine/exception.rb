module RestRedmine
  class Exception < RuntimeError
    attr_accessor :response
    attr_writer :message

    def initialize message, response=nil
      @message = message
      @response = response if response
    end

    def message
      @message || self.class.name
    end

    def to_s
      "#{self.class}: #{@message}"
    end
  end
end