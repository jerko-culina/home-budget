module Api
  class CategoriesController < AuthenticatedController
    def index

      categories = Categories::Finder.new(user: current_user).all
      respond_with categories, serializer: Api::CategorySerializer
    end

    def show
      category = Categories::Finder.new(user: current_user).find(params[:id])
      respond_with category, serializer: Api::CategorySerializer
    end

    def create
      creator = Categories::Creator.new(user: current_user)

      creator.create(create_params)
      
      respond_with creator.category, serializer: Api::CategorySerializer
    end

    def update
      category = Categories::Finder.new(user: current_user).find(params[:id])

      updater = Categories::Updater.new(user: current_user, category: category)
      
      updater.update(update_params) 

      respond_with updater.category, serializer: Api::CategorySerializer
    end

    def destroy
      category = Categories::Finder.new(user: current_user).find(params[:id])

      category.destroy

      head :no_content
    end

    private

    def create_params
      params.require(:category).permit(*Categories::Creator.permitted_params)
    end

    def update_params
      params.require(:category).permit(*Categories::Updater.permitted_params)
    end
  end
end