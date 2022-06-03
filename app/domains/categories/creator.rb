module Categories
  class Creator
    def self.permitted_params
      [:name]
    end

    attr_reader :user

    def initialize(user:)
      @user = user
    end
    
    def category
      @category ||= Category.new(user: user)
    end
  end
end