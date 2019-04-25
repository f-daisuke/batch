# frozen_string_literal: true

class ApplicationBatch
  attr_accessor :conf
  def initialize
    load_conf
  end

  def load_conf
    self.conf = Settings.application_batch
  end
end
