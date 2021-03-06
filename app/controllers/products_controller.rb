class ProductsController < ApplicationController
  # GET /showcase
  def showcase
    @products = Product.all
  end

  # GET /products
  # GET /products.json
  def index
    @products = Product.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  def hag
    @hag = Hag.new(params[:hag])
    @hag.product = Product.find params[:id]
    @hag.save
    @products = Product.all
    flash.now.alert = "Great Job!"
    render "showcase"
  end
  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])
    @hag = Hag.new
    @hag.product = @product

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  # GET /products/1/stats
  def stats
    @product = Product.find(params[:id])
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title({ :text=> @product.name})
      f.options[:xAxis][:categories] = ['0', '50', '100', '150', '200', '250']
      f.series(:type=> 'spline',:name=> 'Price point ($)', :data=> [1500, 1450, 1400, 1300, 1200, 1000])
      f.series(:type=> 'spline',:name=> 'Whole Sale ($)', :data=> [1200, 1200, 1200, 1200, 1200, 1200])
      f.colors[:colors] = ['#1ABC9C','#2ECC71','#A0E12A','#A0EEAA','#A0DE12A']
      # f.options[:chart][:backgroundColor] = '#3498DB'
      # f.options[:yAxis][:alternateGridColor] = '#2980B9'
      # f.options[:yAxis][:gridLineColor] = ''
    end
  end
end
