ActiveAdmin.register Product do
config.per_page = [10, 50, 100]

  filter :user
  filter :name
  filter :price
  filter :short_description
  filter :created_at
  filter :updated_at

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :user_id, :name, :price, :short_description, :full_description
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

sidebar :recent_orders, :only => :show do
  Order.find_with_product(resource).limit(5).collect do |order|
      link_to('This product is bought by ' + order.user.name + ' at ' + order.created_at.strftime("%Y-%m-%d %I:%M%P"), admin_order_path(order))
  end.join(content_tag("br")).html_safe
end

end
