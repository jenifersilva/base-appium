# frozen_string_literal: true

require 'yaml'

# Data Helpers
module DataHelpers
  def self.user
    YAML.load_file('features/data/users.yml')
  end
end
