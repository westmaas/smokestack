class SmokeTestsController < ApplicationController
  # GET /smoke_tests
  # GET /smoke_tests.json
  # GET /smoke_tests.xml
  def index
    @smoke_tests = SmokeTest.all

    if params[:table_only] then
      render :partial => "table"
    else
      respond_to do |format|
        format.html # index.html.erb
        format.json  { render :json => @smoke_tests }
        format.xml  { render :xml => @smoke_tests }
      end
    end
  end

  # GET /smoke_tests/1
  # GET /smoke_tests/1.json
  # GET /smoke_tests/1.xml
  def show
    @smoke_test = SmokeTest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @smoke_test }
      format.xml  { render :xml => @smoke_test }
    end
  end

  # GET /smoke_tests/new
  # GET /smoke_tests/new.xml
  def new
    @smoke_test = SmokeTest.new

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @smoke_test }
      format.xml  { render :xml => @smoke_test }
    end
  end

  # GET /smoke_tests/1/edit
  def edit
    @smoke_test = SmokeTest.find(params[:id])
  end

  # POST /smoke_tests
  # POST /smoke_tests.xml
  def create
    @smoke_test = SmokeTest.new(params[:smoke_test])

    respond_to do |format|
      if @smoke_test.save
        format.html { redirect_to(@smoke_test, :notice => 'Smoke test was successfully created.') }
        format.json  { render :json => @smoke_test, :status => :created, :location => @smoke_test }
        format.xml  { render :xml => @smoke_test, :status => :created, :location => @smoke_test }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @smoke_test.errors, :status => :unprocessable_entity }
        format.xml  { render :xml => @smoke_test.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /smoke_tests/1
  # PUT /smoke_tests/1.xml
  def update
    @smoke_test = SmokeTest.find(params[:id])

    respond_to do |format|
      if @smoke_test.update_attributes(params[:smoke_test])
        format.html { redirect_to(@smoke_test, :notice => 'Smoke test was successfully updated.') }
        format.json  { head :ok }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @smoke_test.errors, :status => :unprocessable_entity }
        format.xml  { render :xml => @smoke_test.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /smoke_tests/1
  # DELETE /smoke_tests/1.xml
  def destroy
    @smoke_test = SmokeTest.find(params[:id])
    json=@smoke_test.to_json
    xml=@smoke_test.to_xml
    @smoke_test.destroy

    respond_to do |format|
      format.html { redirect_to(smoke_tests_url) }
      format.json  { render :json => json }
      format.xml  { render :xml => xml }
    end
  end

  # POST /smoke_tests/1/run_job
  def run_job
    @smoke_test = SmokeTest.find(params[:id])

    job=Job.create(
        :smoke_test => @smoke_test
    )

    respond_to do |format|
      format.html { redirect_to(job) }
      format.json  { head :ok }
      format.xml  { head :ok }
    end

  end

end