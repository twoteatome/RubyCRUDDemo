class API < Grape::API
  prefix 'api'
  version 'v1', using: :path
  format :json

  helpers do
    def dummy_name
      "dummy"
    end
    def err401
      error!('401 Unauthorized', 401) 
    end
  end

  resource :products do

    get :all do
      Product.all
    end

    desc "Return a product"
    params do
      requires :id, type: String
      requires :name, type: String
    end
    post :update do
      @product = Product.find(params[:id])
      @product.name = params[:name]
      if @product.save
        "Success"
      else
        "Failed"
      end
    end
  end
end