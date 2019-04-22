class UsersController < AuthenticationController
    before_action :set_user, only: [:show, :edit, :update]
    before_action :is_admin

    # Shows all users
    def index

        bHash = Hash.new
        bHash['Admins'] = 'admin'
        bHash['Regular Users'] = 'user'
        @roles = bHash

        params[:role]='admin' if params[:role].nil?

        if params[:commit] == 'Clear' and !params[:name].nil?
            params.delete(:name)
        end

        @users = User
                    .all
                    .select('users.*')
                    .order(Arel.sql('id DESC'))

        @users = @users.reorder(Arel.sql('id DESC'))

        # puts Application.all.inspect

        if !params[:role].nil? and !params[:role].empty?
            if params[:role] == 'admin'
                @users = @users.where('role=?', params[:role])
            elsif params[:role] == 'user'
                @users = @users.where("role!='admin'")
            end
        end

        if !params[:name].nil? and !params[:name].empty?
            @users = @users.where('lower(users.name) LIKE ?', "%#{params[:name].downcase}%")
            @users = @users.reorder(Arel.sql('id DESC'))
        end

        ppHash = Hash.new
        ppHash['10'] = 10
        ppHash['25'] = 25
        ppHash['50'] = 50
        @per_page_hash = ppHash

        if params[:per_page].nil? || params[:per_page].empty?
            params[:per_page] = 10
        end

        if @users.all.to_a.length >= 10
            @users = @users.all.paginate(page: params[:page], per_page: params[:per_page])
        end

    end

    # Shows a specific users info
    def show
    end

    # Edit 
    def edit
        @validRoleList = [ ['User','user'], ['Admin','admin']]
    end

    # Update
    def update
        respond_to do |format|
            if @user.update!(role: user_params[:role])
                format.html { redirect_to @user, notice: 'User was successfully updated.' }
                format.json { render :show, status: :ok, location: @user }
            end
        end
    end

    private

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:role)
    end
end
