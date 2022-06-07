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

    def create(params)
      category.assign_attributes(params)
      category.save
    end
  end
end