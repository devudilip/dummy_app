class GeosController < ApplicationController
  # GET /geos
  # GET /geos.xml
  def index
    @geos = Geo.all

   data_table = GoogleVisualr::DataTable.new
  data_table.new_column('string', 'Country')
  data_table.new_column('number', 'Popularity')
  @geos.each do |g|
  data_table.add_rows([
      [g.country,g.popularity]
                ]);
  end

  opts = { :width => 500, :height => 300 }
  @chart = GoogleVisualr::Interactive::GeoChart.new(data_table, opts)
  end

  # GET /geos/1
  # GET /geos/1.xml
  def show
    @geo = Geo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @geo }
    end
  end

  # GET /geos/new
  # GET /geos/new.xml
  def new
    @geo = Geo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @geo }
    end
  end

  # GET /geos/1/edit
  def edit
    @geo = Geo.find(params[:id])
  end

  # POST /geos
  # POST /geos.xml
  def create
    @geo = Geo.new(params[:geo])

    respond_to do |format|
      if @geo.save
        format.html { redirect_to(@geo, :notice => 'Geo was successfully created.') }
        format.xml  { render :xml => @geo, :status => :created, :location => @geo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @geo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /geos/1
  # PUT /geos/1.xml
  def update
    @geo = Geo.find(params[:id])

    respond_to do |format|
      if @geo.update_attributes(params[:geo])
        format.html { redirect_to(@geo, :notice => 'Geo was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @geo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /geos/1
  # DELETE /geos/1.xml
  def destroy
    @geo = Geo.find(params[:id])
    @geo.destroy

    respond_to do |format|
      format.html { redirect_to(geos_url) }
      format.xml  { head :ok }
    end
  end
end
