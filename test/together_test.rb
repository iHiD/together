require "test_helper"

module Together
  class TogetherTest < Minitest::Test
    def test_that_it_has_a_version_number
      refute_nil ::Together::VERSION
    end

    def test_sets_default_correctly
      mandates = [:foo]
      executor = mock(call: nil)
      Executor.expects(:new).with(mandates,
                                  timeout: 1,
                                  raise_exceptions: true
                                 ).returns(executor)
      Together.(*mandates)
    end
  end
end
