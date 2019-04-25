# frozen_string_literal: true

class Import < ApplicationBase
  def execute
    execute_files_by_line
  end

  def execute_each(json)
    h = Oj.load(json, mode: :compat)

    Feed.create(h)
    json
  end

  def in_path
    'converted'
  end

  def out_path(file)
    base_file = File.basename(file)
    "#{Rails.root}/data/imported/#{base_file}"
  end
end
