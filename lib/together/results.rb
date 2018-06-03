module Together
  class Results < Array

    attr_reader :exceptions
    def initialize(size, *args)
      super(size, *args)
      @exceptions = Array.new(size)
    end

    def success?
      @exceptions.all?(&:nil?)
    end
  end
end
