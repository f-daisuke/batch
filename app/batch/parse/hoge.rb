# frozen_string_literal: true

class Parse::Hoge < Parse::Base
  def execute
    execute_files_by_line
  end

  def execute_each(line)
    Oj.dump(to_hash(line), mode: :compat)
  end

  def to_hash(line)
    line_array = line.split(',')

    {
      type1: line_array[0],
      type2: line_array[1],
      type3: line_array[2],
      type4: line_array[3]
    }
  end

  def in_path
    'parse/hoge'
  end

  def out_path(file)
    base_file = File.basename(file)
    "#{Rails.root}/data/parsed/#{base_file}"
  end
end
