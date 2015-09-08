class MachinesController < ApplicationController
  before_action :set_machine, only: [:show, :edit, :update, :destroy]

  # GET /machines
  # GET /machines.json
  def index
    @machines = Machine.all
  end

  # GET /machines/1
  # GET /machines/1.json
  def show
  end

  # GET /machines/new
  def new
    @machine = Machine.new
  end

  # GET /machines/1/edit
  def edit
  end

  # POST /machines
  # POST /machines.json
  def create
    @machine = Machine.new(machine_params)
    respond_to do |format|
      if @machine.save
        
        #TO-DO
        #Move this process to a backround job with delayed_job
        #Repeated in the update method
        client = Swiftype::Client.new(:api_key => ENV['SWIFTYPE_API'])
        client.create_or_update_document(ENV['SWIFTYPE_SLUG'], ENV['SWIFTYPE_DOC'], {
          :external_id => @machine.id,
          :fields => [
            {:name => 'title', :value => @machine.title, :type => 'string'},
            {:name => 'url', :value => machine_url(@machine), :type => 'enum'},
            {:name => 'create_at', :value => @machine.created_at.iso8601, :type => 'date'},
          ]
        })
        format.html { redirect_to @machine, notice: 'Machine was successfully created.' }
        format.json { render :show, status: :created, location: @machine }
      else
        format.html { render :new }
        format.json { render json: @machine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /machines/1
  # PATCH/PUT /machines/1.json
  def update
    respond_to do |format|
      if @machine.update(machine_params)
        
        #TO-DO
        #Move this process to a background job with delayed_job
        #Repeated in the create method
        client = Swiftype::Client.new(:api_key => ENV['SWIFTYPE_API'])
        client.create_or_update_document(ENV['SWIFTYPE_SLUG'], ENV['SWIFTYPE_DOC'], {
          :external_id => @machine.id,
          :fields => [
            {:name => 'title', :value => @machine.title, :type => 'string'},
            {:name => 'url', :value => machine_url(@machine), :type => 'enum'},
            {:name => 'create_at', :value => @machine.created_at.iso8601, :type => 'date'},
          ]
        })
        
        format.html { redirect_to @machine, notice: 'Machine was successfully updated.' }
        format.json { render :show, status: :ok, location: @machine }
      else
        format.html { render :edit }
        format.json { render json: @machine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /machines/1
  # DELETE /machines/1.json
  def destroy
    @machine.destroy
    #TO-DO
    #Move this process to a background job with delayed_job
    #Repeated in the create method
    client = Swiftype::Client.new(:api_key => ENV['SWIFTYPE_API'])
    client.destroy_document(ENV['SWIFTYPE_SLUG'], ENV['SWIFTYPE_DOC'], @machine.id)
    respond_to do |format|
      format.html { redirect_to machines_url, notice: 'Machine was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_machine
      @machine = Machine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def machine_params
      params.require(:machine).permit(:title)
    end
end
