module Categories
  class Updater
    def self.permitted_params
      [:name]
    end
    
    attr_reader :user, :category

    def initialize(user:, category:)
      @user = user
      @category = category
    end
    
    def update(params)
      category.update(params)
    end
  end
end