module Users
  class Processor
    def full_name(user)
      "#{user.first_name} #{user.last_name}"
    end
  end
end
