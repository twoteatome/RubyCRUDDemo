ActiveAdmin.register Order do

  config.per_page = [10, 50, 100]

  actions :index, :show

  filter :product
  filter :user
  filter :quantity
  filter :created_at

  scope :all, :default => true
  scope :in_progress
  scope :complete

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#

 permit_params :user_id, :product_id, :quantity, :status
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  index do
	selectable_column
    id_column
    column "Product" do |order|
    	link_to order.product.name, admin_product_path(order.product)
    end
    column "Customer" do |order|
    	link_to order.user.name, admin_user_path(order.user)
    end
    column :quantity
    column "Total" do |order|
      number_to_currency order.product.price * order.quantity, :unit => "円"
    end
    column "Status" do |order|
      status_tag(order.state)
    end
    column :created_at
    action_item :view, only: :show do
      link_to 'View on site', post_path(post) if post.published?
    end
  end

end
