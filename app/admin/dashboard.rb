ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Recent Products" do
          table_for Product.order("id desc").limit(10) do
            column("Name") { |product| link_to(product.name, admin_product_path(product)) }
            column("Price") { |product| product.price }
            column("Description")   { |product| product.short_description }
          end
        end
      end

      column do
        panel "Recent Customers" do
          table_for User.order("id desc").limit(10).each do |_user|
            column(:id)    { |user| user.id }
            column(:name)    { |user| link_to(user.name, admin_user_path(user)) }
            column(:created_at)    { |user| user.created_at }
          end
        end
      end
    end # columns

    columns do
      column do
        panel "News" do
          ul do
            li "KASPERSKY'S STELLAR ANTIVIRUS FINALLY GOES FREE"
            li "RYZEN SALES LEAD AMD EARNINGS, DESPITE ISSUES WITH GAME OPTIMIZATION AND MINING"
            li "ADOBE FLASH WILL DIE BY 2020, ADOBE AND BROWSER MAKERS SAY"
            li "RED HAT'S BOLTRON SNAPS TOGETHER A MODULAR LINUX SERVER"
          end
        end
      end

      column do
        panel "Recent Orders" do
          table_for Order.joins(:user).joins(:product).select('orders.*, users.name, products.price, products.name as product_name').order("id desc").limit(10).each do
            column("ID") { |order| link_to(order.id, admin_order_path(order)) }
            column("Product Name") { |order| link_to(order.product_name, admin_product_path(order.product_id)) }
            column("Seller") { |order| link_to(order.name, admin_user_path(order.user_id)) }
            column("Quantity")   { |order| order.quantity }
            column("Price")   { |order| number_to_currency order.quantity * order.price, :unit => "円" }
            column("Status")   { |order| status_tag(order.state) }
          end
        end
      end
    end # columns

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
