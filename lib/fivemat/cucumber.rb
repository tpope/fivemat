require 'cucumber/formatter/progress'

module Fivemat
  class Cucumber < ::Cucumber::Formatter::Progress
    include ElapsedTime

    def before_feature(feature)
      @io.print "#{feature.file} "
      @io.flush
      @exceptions = []
      @start_time = Time.now
    end

    def after_feature(feature)
      print_elapsed_time @io, @start_time
      @io.puts

      @exceptions.each do |(exception, status)|
        print_exception(exception, status, 2)
      end
    end

    def exception(exception, status)
      @exceptions << [exception, status]
      super
    end

    def after_features(features)
      @io.puts
      print_stats(features, @options)
      print_passing_wip(@options)
    end
  end
end
