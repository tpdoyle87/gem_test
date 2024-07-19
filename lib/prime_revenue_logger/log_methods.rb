module PrimeRevenueLogger
  module LogMethods
    def timed_def(method_name)
      original_method = instance_method(method_name)

      define_method(method_name) do |*args, &block|
        start_time = Time.now
        info 'Starting', method_name

        result = original_method.bind(self).call(*args, &block)

        info "Finished: #{Time.now - start_time}", method_name
        result
      end
    end

    def log_level
      PrimeRevenueLogger.logger.level
    end

    def fatal(arg1 = nil, arg2 = nil, &block)
      return if log_level > Logger::FATAL
      if block_given?
        write_log(Logger::FATAL, message: nil, context: arg1, &block)
      else
        arg2 ||= calling_method
        write_log(Logger::FATAL, message: arg1, context: arg2)
      end
    end

    def error(arg1 = nil, arg2 = nil, &block)
      return if log_level > Logger::ERROR
      if block_given?
        write_log(Logger::ERROR, message: nil, context: arg1, &block)
      else
        arg2 ||= calling_method
        write_log(Logger::ERROR, message: arg1, context: arg2)
      end
    end

    def warning(arg1 = nil, arg2 = nil, &block)
      return if log_level > Logger::WARN
      if block_given?
        write_log(Logger::WARN, message: nil, context: arg1, &block)
      else
        arg2 ||= calling_method
        write_log(Logger::WARN, message: arg1, context: arg2)
      end
    end

    def info(arg1 = nil, arg2 = nil, &block)
      return if log_level > Logger::INFO
      if block_given?
        write_log(Logger::INFO, message: nil, context: arg1, &block)
      else
        arg2 ||= calling_method
        write_log(Logger::INFO, message: arg1, context: arg2)
      end
    end

    def debug(arg1 = nil, arg2 = nil, &block)
      if block_given?
        write_log(Logger::DEBUG, message: nil, context: arg1, &block)
      else
        arg2 ||= calling_method
        write_log(Logger::DEBUG, message: arg1, context: arg2)
      end
    end

    def calling_method(level = 1)
      caller[level][/`.*'/][1..-2]
    end

    def write_log(level, context: nil, message: nil, &block)
      context ||= calling_method
      PrimeRevenueLogger.logger.add(level, message, context.nil? ? name : "#{name}.#{context}", &block)
    end
  end
end

module ClassLogger
  include PrimeRevenueLogger::LogMethods
  def self.included(base)
    base.extend PrimeRevenueLogger::LogMethods
  end

  def write_log(level, context: nil, message: nil, &block)
    context ||= "#{self.class.name}(#{id})"
    if message.present? || block_given?
      PrimeRevenueLogger.logger.add(level, message, context, &block)
    else
      PrimeRevenueLogger.logger.add(level, attributes.compact, context)
    end
  end
end

module ModelLogger
  include PrimeRevenueLogger::LogMethods
  def self.included(base)
    base.extend PrimeRevenueLogger::LogMethods
  end

  def write_log(level, context: nil, message: nil, &block)
    context ||= "#{self.class.name}(#{id})"
    if message.present? || block_given?
      PrimeRevenueLogger.logger.add(level, message, context, &block)
    else
      PrimeRevenueLogger.logger.add(level, attributes.compact, context)
    end
  end
end

class CustomLoggerBase
  extend PrimeRevenueLogger::LogMethods
end
