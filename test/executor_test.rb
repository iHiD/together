require "test_helper"

module Together
  class ExecutorTest < Minitest::Test

    def test_it_runs_mandate_commands
      sm1 = Proc.new { :sm1 }
      sm2 = Proc.new { :sm2 }
      res = Executor.([sm1, sm2], timeout: 1, raise_exceptions: false)
      assert_equal [:sm1, :sm2], res
    end

    def test_it_runs_mandate_commands_in_parallel
      sm1 = Proc.new { sleep(0.01); :sm1 }
      sm2 = Proc.new { sleep(0.01); :sm2 }

      start_time = Time.now.to_f
      res = Executor.([sm1, sm2], timeout: 1, raise_exceptions: false)
      assert (Time.now.to_f - start_time) < 0.015
    end

    def test_it_maintains_order_regardless_of_speed
      sm1 = Proc.new { sleep(0.03); :sm1 }
      sm2 = Proc.new { :sm2 }
      sm3 = Proc.new { sleep(0.02); :sm3 }

      start_time = Time.now.to_f
      res = Executor.([sm1, sm2, sm3], timeout: 1, raise_exceptions: false)
      assert_equal [:sm1, :sm2, :sm3], res
    end

    def test_execution_times_out
      sm1 = Proc.new { sleep(0.05) }
      sm2 = Proc.new { sleep(0.1) }
      Executor.([sm1], timeout: 1, raise_exceptions: false)

      assert_raises TimeoutError do
        Executor.([sm2], timeout: 0.08, raise_exceptions: false)
      end
    end

    def test_exceptions_are_raised_by_default
      sm = Proc.new { raise StandardError.new("foobar") }
      assert_raises do
        Executor.([sm], timeout: 1, raise_exceptions: true)
      end
    end

    def test_exceptions_are_not_raised_if_toggled
      msg = "foobar"
      sm = Proc.new { raise StandardError.new(msg) }
      results = Executor.([sm], timeout: 1, raise_exceptions: false)
      assert_equal msg, results.exceptions.first.message
    end
  end
end
