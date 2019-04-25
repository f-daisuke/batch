# frozen_string_literal: true

require 'fileutils'
class ApplicationBase < ApplicationBatch
  attr_accessor :logger
  def initialize
    super
    prepare_logger
  end

  delegate :info, to: :logger, prefix: true

  def prepare_logger
    execute_class_name = self.class.name.underscore
    %w[parse convert import].each do |dir_name|
      FileUtils.mkdir_p([conf.log_path, '/', dir_name].join)
      FileUtils.mkdir_p([conf.tmp_path, '/', dir_name].join)
    end
    self.logger = Logger.new([conf.log_path, '/', "#{execute_class_name}_main.log"].join, conf.log_logrotate_option.generation, conf.log_logrotate_option.size)
    logger.formatter = ::Logger::Formatter.new
    logger.level = Logger::INFO
  end

  def execute_files_by_line
    in_files.each do |file|
      execute_file_by_line(file)
    end
  end

  def execute_file_by_line(file)
    logger_info file
    main_execute_file_by_line(file)
  end

  def main_execute_file_by_line(file)
    error_count = 0
    File.open(out_path(file), 'w') do |output|
      File.foreach(file) do |line|
        out_text = get_out_text(line: line.chomp, file: file)
        output.puts out_text if out_text.present?
      rescue StandardError => e
        # TODO
      end
    end
  end

  def get_out_text(parameters = {})
    line = parameters[:line]
    out_text = execute_each(line)
    out_text if out_text.present?
  end

  def execute_each(_data)
    raise NotImplementedError, 'must override'
  end

  def in_path
    raise NotImplementedError, 'must override'
  end

  def out_path(_file)
    raise NotImplementedError, 'must override'
  end

  def in_files
    return [] if in_path.blank?

    Dir.glob("#{Rails.root}/data/#{in_path}/*").sort_by { |f| File.mtime(f) }
  end
end
