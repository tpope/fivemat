require 'cucumber/formatter/progress'

module Fivemat
  class Cucumber < ::Cucumber::Formatter::Progress
    def label(feature)
      feature.short_name
    end

    def before_feature(feature)
      @io.print "#{label(feature)} "
      @io.flush
      @exceptions = []
    end

    def after_feature(feature)
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
      print_snippets(@options)
      print_passing_wip(@options)
    end
  end
end
