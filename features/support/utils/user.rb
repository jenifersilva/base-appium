# frozen_string_literal: true

# Users methods
module User
  def select_user(type)
    DataHelpers.user[type]
  end
end

World(User)
