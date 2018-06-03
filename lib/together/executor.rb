module Together
  class Executor
    include Mandate

    attr_reader :mandates, :timeout_time, :raise_exceptions,
                :threads,
                :results, :exceptions

    # Timeout is in seconds
    def initialize(mandates,
                   timeout: ,
                   raise_exceptions: )
      @mandates = mandates
      @timeout_time = Time.now.to_f + timeout
      @raise_exceptions = raise_exceptions

      @results = Results.new(mandates.size)
      @threads = []
    end

    def call
      execute_mandates
      wait_for_threads
      results
    end

    private

    def execute_mandates
      mandates.each.with_index do |mandate, i|
        @threads << Thread.new do
          begin
            @results[i] = mandate.()
          rescue => e
            @results.exceptions[i] = e
          end
        end
      end
    end

    def wait_for_threads
      while Time.now.to_f < timeout_time

        # It is important to check for exceptions before
        # checking to see if anything is finished else we hit
        # a race condition.
        if raise_exceptions && !results.exceptions.all?(&:nil?)
          raise results.exceptions.find{|e|!e.nil?}
        end

        return true unless threads.any?(&:alive?)

        sleep(0.001)
      end

      raise TimeoutError.new
    end
  end
end

