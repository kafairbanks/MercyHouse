class MercyroomsController < AuthenticationController
  before_action :set_mercyroom, only: [:show, :edit, :update, :destroy]
  
  # Only admins can see mercy rooms stuff
  before_action :is_admin
  # GET /mercyrooms
  # GET /mercyrooms.json
  def index
    if !(params['name'].nil? || params['name'].empty?)
      @mercyrooms = Mercyroom.select('mercyrooms.id, "RoomName", mercyhomes_id, "RoomDesc", "firstfloor", "HouseName"')
                        .joins("INNER JOIN mercyhomes ON mercyrooms.mercyhomes_id = mercyhomes.id")
                        .where('lower("HouseName") LIKE ?', "%#{params['name'].downcase}%")
    else
      @mercyrooms = Mercyroom.all.select('mercyrooms.id, "RoomName", mercyhomes_id, "RoomDesc", "firstfloor", "HouseName"')
                        .joins("INNER JOIN mercyhomes ON mercyrooms.mercyhomes_id = mercyhomes.id")
    end
  end

  # GET /mercyrooms/1
  # GET /mercyrooms/1.json
  def show
  end

  # GET /mercyrooms/new
  def new
    @mercyroom = Mercyroom.new
  end

  # GET /mercyrooms/1/edit
  def edit
  end

  # POST /mercyrooms
  # POST /mercyrooms.json
  def create
    if mercyroom_params.has_key?(:mercyhomes_id) && (mercyroom_params[:mercyhomes_id] != "")
      @mercyroom = Mercyroom.new(mercyroom_params)
    else
      @new_hash = mercyroom_params
      @new_hash["mercyhomes_id"] = session[:mercyhomes_id]
      @mercyroom = Mercyroom.new(@new_hash)
    end

    respond_to do |format|
      begin
        if @mercyroom.save!
          format.html { redirect_to @mercyroom, notice: 'Room was successfully created.' }
          format.json { render :show, status: :created, location: @mercyroom }
        end
      rescue
        format.html { render :new }
        format.json { render json: @mercyroom.errors, status: :unprocessable_entity }
      end
    end

    # Used method create to bypass having to store a number in the session
    # In the model, it checks that the mercy home exists in the database before saving
=begin
    @mercyroom = Mercyroom.create(mercyhomes_id: mercyroom_params[:mercyhomes_id] ,RoomName: mercyroom_params[:RoomName], RoomDesc: mercyroom_params[:RoomDesc], firstfloor: mercyroom_params[:firstfloor] )
    
    respond_to do |format|
      begin
        if @mercyroom.save!
          format.html { redirect_to @mercyroom, notice: 'Mercyroom was successfully created.' }
          format.json { render :show, status: :created, location: @mercyroom }
        end
      rescue
        format.html { render :new }
        format.json { render json: @mercyroom.errors, status: :unprocessable_entity }
      end
    end
=end
  end

  # PATCH/PUT /mercyrooms/1
  # PATCH/PUT /mercyrooms/1.json
  def update
    respond_to do |format|
      begin
        if @mercyroom.update!(mercyroom_params)
          format.html { redirect_to @mercyroom, notice: 'Mercyroom was successfully updated.' }
          format.json { render :show, status: :ok, location: @mercyroom }
        end
      rescue
        format.html { render :edit }
        format.json { render json: @mercyroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mercyrooms/1
  # DELETE /mercyrooms/1.json
  def destroy
    @mercyroom.destroy
    respond_to do |format|
      format.html { redirect_to mercyrooms_url, notice: 'Mercyroom was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mercyroom
      @mercyroom = Mercyroom.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mercyroom_params
      params.require(:mercyroom).permit(:mercyhomes_id, :RoomName, :RoomDesc, :firstfloor)
    end
end
