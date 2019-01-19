class Barcode < ApplicationRecord
  def initialize(order, view)
    super({
              :top_margin => 70,
              :page_size => 'A4',
              :font_size => 10,
              :text  => 8
          })

    @order = order
    @view = view
    order_number
    barcode
  end

  def order_number
    text "Order #{@order.order_number}"
  end

  def barcode
    barcode = Barby::Code39.new @order.order_number
    barcode.annotate_pdf(self)
  end
end