module Products

  class Data < Grape::API

    helpers do
      def result status, message, products
        present :status, status
        present :message, message
        present :products, products
      end
    end

    resource :products do
      desc "List all products"
      get do
        result(0, "Success", Product.all)
      end

      desc "Create a new product"
	    params do
	      requires :name, type: String
	      requires :user_id, type: String
	      requires :price, type: Integer
	      requires :short_description, type: String
	      requires :full_description, type: String
	    end
	    post do
	      @product = Product.new
        @product.name = params[:name]
        @product.user_id = params[:user_id]
        @product.price = params[:price]
        @product.short_description = params[:short_description]
	      @product.full_description = params[:full_description]

	      if @product.save
	        result(0, "Success", nil)
	      else
	        result(1, "Failed", nil)
	      end
	    end

	    desc "Delete a product"
      params do
	      requires :id, type: String
	    end
      delete ':id' do
        begin
          @product = Product.find(params[:id])

          if @product.delete
            result(0, "Success", nil)
          else
            result(1, "Failed", nil)
          end
        rescue ActiveRecord::RecordNotFound
          result(2, "Product not found", nil)
        rescue ActiveRecord::RecordInvalid
          result(3, "Product invalid", nil)
        end
      end

      desc "Update price or name for product"
      params do
        requires :id, type: String
        requires :name, type: String
	      requires :price, type: Integer
      end
      put ':id' do
        begin
          @product = Product.find(params[:id])
          @product.name = params[:name]
          @product.price = params[:price]

          if @product.save
            result(0, "Success", nil)
          else
            result(1, "Failed", nil)
          end
        rescue ActiveRecord::RecordNotFound
          result(2, "Product not found", nil)
        rescue ActiveRecord::RecordInvalid
          result(3, "Product invalid", nil)
        end
      end
    end
  end
end