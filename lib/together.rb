require 'mandate'

require "together/version"
require "together/exceptions"

require "together/results"
require "together/executor"

module Together
  def self.call(*mandates,
                timeout: 1,
                raise_exceptions: true)

    Executor.(mandates,
              timeout: timeout,
              raise_exceptions: raise_exceptions)
  end
end
