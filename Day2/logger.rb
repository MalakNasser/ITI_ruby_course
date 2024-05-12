require 'date'

module Logger
    def self.log_info(message)
        log_message = format_log_message('info', message)
        append_in_logger(log_message)
    end

    def self.log_warning(message)
        log_message = format_log_message('warning', message)
        append_in_logger(log_message)
    end

    def self.log_error(message)
        log_message = format_log_message('error', message)
        append_in_logger(log_message)
    end

    def self.format_log_message(log_type, message)
        timestamp = DateTime.now.rfc3339
        "#{timestamp} -- #{log_type} -- #{message}"
    end

    def self.append_in_logger(log_message)
        File.open('app.logs', 'a') do |file|
            file.puts(log_message)
        end
    end
end
