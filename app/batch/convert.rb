# frozen_string_literal: true

class Convert < ApplicationBase
  FILTERS = [
    Filter::Upcase
  ].freeze

  def execute
    execute_files_by_line
  end

  def execute_each(json)
    h = Oj.load(json, mode: :compat)

    filters.each do |filter|
      return {} if h.blank?

      h = filter.filter(h, self)
    end
    Oj.dump(h, mode: :compat)
  end

  def filters
    @filters ||= FILTERS.map(&:new)
  end

  def in_path
    'parsed'
  end

  def out_path(file)
    base_file = File.basename(file)
    "#{Rails.root}/data/converted/#{base_file}"
  end
end
