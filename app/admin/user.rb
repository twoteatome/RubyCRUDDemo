ActiveAdmin.register User do
config.per_page = [10, 50, 100]

  filter :name
  filter :created_at
  filter :updated_at

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name, :password_digest
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

sidebar :created_products, :only => :show do
  Product.find_with_user(resource).limit(10).collect do |product|
      link_to('This user has created ' + product.name + ' at ' + product.created_at.strftime("%Y-%m-%d %I:%M%P"), admin_product_path(product))
  end.join(content_tag("br")).html_safe
end

end
