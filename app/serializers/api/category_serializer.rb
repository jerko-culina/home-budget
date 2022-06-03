module Api
  class CategorySerializer < Blueprinter::Base
    field :id
    field :name
  end
end