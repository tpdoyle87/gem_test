require 'json'

class Formatter < Logger::Formatter
  def call(severity, time, progname, msg)
    class_name = progname.to_s.split(':').first if progname
    log_entry = {
      severity: severity,
      time: format_datetime(time),
      progname: progname,
      message: msg,
      className: class_name
    }
    log_entry.to_json + "\n"
  end
end