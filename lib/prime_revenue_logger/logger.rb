require 'active_support/logger'
require 'prime_revenue_logger/formatter'

module PrimeRevenueLogger
  class Logger < ActiveSupport::Logger
    def add(severity, message = nil, progname = nil)
      progname = "#{progname.class.name}: #{progname.message}\n#{progname.backtrace}" if progname.is_a? StandardError
      super(severity, message, progname)
    end
  end

  def self.logger
    @@logger ||= PrimeRevenueLogger::Logger.new("./log/#{ENV.fetch('RAILS_ENV', 'development')}.log").tap do |logger|
      logger.formatter = PrimeRevenueLogger::Formatter.new
    end
    @@logger
  end
end
