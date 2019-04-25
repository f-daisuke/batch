# frozen_string_literal: true

class Filter::Upcase
  def filter(hash, _context)
    return {} if hash.blank?

    hash['type1'] = hash['type1'].upcase if hash['type1']
    hash
  end
end
