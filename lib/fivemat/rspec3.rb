require 'rspec/core/formatters/base_text_formatter'

module Fivemat
  class RSpec3 < ::RSpec::Core::Formatters::BaseTextFormatter
    include ElapsedTime

    # See fivemat.rb for formatter registration.

    def initialize(output)
      super(output)
      @group_level = 0
      @index_offset = 0
      @cumulative_failed_examples = []
      @failed_examples = []
    end

    def example_passed(notification)
      output.print success_color('.')
    end

    def example_pending(notification)
      super
      output.print pending_color('*')
    end

    def example_failed(event)
      super
      output.print failure_color('F')
    end

    def example_group_started(event)
      if @group_level.zero?
        output.print "#{event.group.description} "
        @failure_output = []
        @start_time = Time.now
      end
      @group_level += 1
    end

    def example_group_finished(event)
      @group_level -= 1
      if @group_level.zero?
        print_elapsed_time output, @start_time
        output.puts

        failed_examples.each_with_index do |example, index|
          if pending_fixed?(example)
            dump_pending_fixed(example, @index_offset + index)
          else
            dump_failure(example, @index_offset + index)
          end
          dump_backtrace(example)
        end
        @index_offset += failed_examples.size
        @cumulative_failed_examples += failed_examples
        failed_examples.clear
      end
    end

    def pending_fixed?(example)
      example.execution_result.pending_fixed?
    end

    def dump_pending_fixed(example, index)
      output.puts "#{short_padding}#{index.next}) #{example.full_description} FIXED"
      output.puts fixed_color("#{long_padding}Expected pending '#{example.execution_result.pending_message}' to fail. No Error was raised.")
    end

    def dump_summary(*args)
      @failed_examples = @cumulative_failed_examples
      super
    end
  end
end
