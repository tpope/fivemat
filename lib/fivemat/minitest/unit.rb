require 'minitest/unit'

module Fivemat
  module MiniTest
    class Unit < ::MiniTest::Unit
      def _run_suites(suites, type)
        offset = 0
        suites.reject do |suite|
          filter = options[:filter] || '/./'
          filter = Regexp.new $1 if filter =~ /\/(.*)\//
          suite.send("#{type}_methods").grep(filter).empty?
        end.map do |suite|
          print "#{suite} "
          result = _run_suite suite, type
          puts
          report.each_with_index do |msg, i|
            puts "%3d) %s" % [offset + i + 1, msg.gsub(/\n/, "\n  ")]
          end
          offset += report.size
          report.clear
          result
        end
      end
    end
  end
end
