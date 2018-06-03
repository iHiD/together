require "test_helper"

module Together
  class ResultsTest < Minitest::Test

    def test_exceptions_is_an_array
      r = Results.new(2)
      assert r.exceptions.is_a?(Array)
      assert r.exceptions.length == 2
    end

    def test_success_respects_exceptions
      r = Results.new(2)
      assert r.success?

      r.exceptions[0] = :foo
      refute r.success?
    end

  end
end
