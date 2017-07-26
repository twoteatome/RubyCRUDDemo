ActiveAdmin.register_page "Report" do

  menu priority: 2

  breadcrumb do
    ['admin', 'common']
  end

  content do
    columns do
      column do
        panel "Product's order report" do
          area_chart Order.group(:product_id).maximum(:quantity)
        end
      end

      column do
        panel "Recent Customers" do
          line_chart User.group("DATE(created_at)").count
        end
      end
    end # columns

    columns do
      column do
        panel "Oder by product" do
          pie_chart Order.group(:product_id).all.count
        end
      end

      column do
        panel "Oder by user" do
          column_chart Order.group(:user_id).count
        end
      end
    end # columns
  end # content
end