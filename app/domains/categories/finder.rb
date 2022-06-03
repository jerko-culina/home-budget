module Categories
  class Finder
    attr_reader :user

    def initialize(user:)
      @user = user
    end

    def find(id)
      all.find(id)
    end

    def find_by(kwargs) 
      all.find_by(**kwargs)
    end

    def all
      Category.where(user: user)
    end
  end
end