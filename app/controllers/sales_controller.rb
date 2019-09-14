class SalesController < ApplicationController
  def new
    @sale=Sale.new
  end

  def create
    @sale = Sale.new(sale_params)
    @sale.total = @sale.value - (@sale.value * @sale.discount / 100)
    
    if @sale.tax == 1 #checkbox seleccionado
      @impuesto = 1
    else
      @impuesto = 1.19
    end
    @sale.total = @sale.total * @impuesto
    
    @sale.save
    redirect_to sales_done_path
    

  end

  def done
    @sales = Sale.all
  end
  
  private
  def sales_params
  params.require(:sale).permit(:code, :detail, :category, :value, :discount, :tax)

  end  
end
