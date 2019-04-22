class MercyhomesController < AuthenticationController
  before_action :set_mercyhome, only: [:show, :edit, :update, :destroy]
  
  # Only admins can see mercy homes stuff
  before_action :is_admin

  # GET /mercyhomes
  # GET /mercyhomes.json
  def index
    @mercyhomes = Mercyhome.all
  end

  # GET /mercyhomes/1
  # GET /mercyhomes/1.json
  def show
    @coordinator = Coordinator.find(@mercyhome.coordinators_id)
  end

  # GET /mercyhomes/new
  def new
    @mercyhome = Mercyhome.new
    @cList = Coordinator.get_all_coords
    @sList = Mercyhome.us_states
    
  end

  # GET /mercyhomes/1/edit
  def edit
    @cList = Coordinator.get_all_coords
  end

  # POST /mercyhomes
  # POST /mercyhomes.json
  def create
    @mercyhome = Mercyhome.new(mercyhome_params)

    begin
      if @mercyhome.save!
        mercyhome_id = @mercyhome.id
        session[:mercyhome_id] = mercyhome_id
        redirect_to new_mercyroom_path(:mercyhomes_id=>mercyhome_id)
      end
    rescue
      render :new
    end

=begin
    @temp_params = mercyhome_params
    @temp_params[:coordinators_id] = @temp_params[:coordinators_id].to_i
    
    @mercyhome = Mercyhome.new(@temp_params)

    # if @mercyhome.save
    #   mercyhome_id = @mercyhome.id
    #   session[:mercyhomes_id] = mercyhome_id
    #   redirect_to @mercyhomes_path()
    # end

    respond_to do |format|
      begin
        if @mercyhome.save!
          format.html { redirect_to mercyhomes_path, notice: 'Mercyhome was successfully created.' }
          format.json { render :show, status: :created, location: @mercyhome }
        end
      rescue
        format.html { render :new }
        format.json { render json: @mercyhome.errors, status: :unprocessable_entity }
      end
    end
=end
  end

  # PATCH/PUT /mercyhomes/1
  # PATCH/PUT /mercyhomes/1.json
  def update
    respond_to do |format|
      begin
        if @mercyhome.update!(mercyhome_params)
          format.html { redirect_to @mercyhome, notice: 'Mercyhome was successfully updated.' }
          format.json { render :show, status: :ok, location: @mercyhome }
        end
      rescue
        format.html { render :edit }
        format.json { render json: @mercyhome.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mercyhomes/1
  # DELETE /mercyhomes/1.json
  def destroy
    @mercyhome.destroy
    respond_to do |format|
      format.html { redirect_to mercyhomes_url, notice: 'Mercyhome was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mercyhome
      @mercyhome = Mercyhome.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mercyhome_params
      params.require(:mercyhome).permit(:HouseName, :HouseAddress, :HouseCity, :HouseState, :HouseZip, :coordinators_id)
    end
end
