class ChartsController < ApplicationController
  # GET /charts
  # GET /charts.xml
  def area_chart
    @charts=Chart.all
   
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Year')
    data_table.new_column('number', 'Sales')
    data_table.new_column('number', 'Expenses')
    @charts.each do |c|
      data_table.add_rows( [
          [c.year, c.sales, c.expenses]
        ])
    end

    opts = { width: 500, height: 340, title: 'CAR SALES EXPENSES', hAxis: {title: 'Year', titleTextStyle: {color: '#FF0000'}} }
    @chart  = GoogleVisualr::Interactive::AreaChart.new(data_table, opts)
    opts2   = { :width => 500, :height => 300, :title => 'CAR SALES EXPENSES IN THIS CHART', :vAxis => {:title => 'KELGINDA MELE'}, :hAxis => {:title => 'YEAR'}, :seriesType => 'bars', :series => {'5' => {:type => 'line'}} }
    @chart2 = GoogleVisualr::Interactive::ComboChart.new(data_table, opts2)



    
  end



  def index
    # @charts=Chart.all
    if params[:startyear].present?
    @charts=Chart.find(:all, :conditions => ["year >= ? AND year <= ?", params[:startyear], params[:endyear]])
    else
      @charts=Chart.all
    end
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Year')
    data_table.new_column('number', 'Sales')
    data_table.new_column('number', 'Expenses')
    @charts.each do |c|
      data_table.add_rows( [
          [c.year, c.sales, c.expenses]
        ])
    end

    opts = { width: 500, height: 340, title: 'CAR SALES EXPENSES', hAxis: {title: 'Year', titleTextStyle: {color: '#FF0000'}} }
    @chart  = GoogleVisualr::Interactive::AreaChart.new(data_table, opts)

  end

  # GET /charts/1
  # GET /charts/1.xml
  def show
    @chart = Chart.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @chart }
    end
  end

  # GET /charts/new
  # GET /charts/new.xml
  def new
    @chart = Chart.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @chart }
    end
  end

  # GET /charts/1/edit
  def edit
    @chart = Chart.find(params[:id])
  end

  # POST /charts
  # POST /charts.xml
  def create
    @chart = Chart.new(params[:chart])

    respond_to do |format|
      if @chart.save
        format.html { redirect_to(@chart, :notice => 'Chart was successfully created.') }
        format.xml  { render :xml => @chart, :status => :created, :location => @chart }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @chart.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /charts/1
  # PUT /charts/1.xml
  def update
    @chart = Chart.find(params[:id])

    respond_to do |format|
      if @chart.update_attributes(params[:chart])
        format.html { redirect_to(@chart, :notice => 'Chart was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @chart.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /charts/1
  # DELETE /charts/1.xml
  def destroy
    @chart = Chart.find(params[:id])
    @chart.destroy

    respond_to do |format|
      format.html { redirect_to(:controller => "charts", :action => "area_chart") }
      format.xml  { head :ok }
    end
  end
end
