class ReportsController < AuthenticationController

    # Only admins can do anything with reports
    before_action :is_admin

    def new
        @report = Report.new
        @homeHash = Report.get_all_homes
    end


    def create
        begin
            @report = Report.generate_report(report_params)
            # Now we just need to pull all the bookings and create a csv
            @report.save
            new_params = {report: {}, id: @report.id}
            redirect_to report_download_path(new_params)
        rescue
            redirect_to new_report_path, notice: "Download failed."
        end
    end

    def download
        begin
            if params[:id].to_i == 0
                raise 'String param'
            end
            respond_to do |format|
                format.csv { send_data Report.to_csv(params[:id].to_i), filename: "#{Date.today}.csv"}
                format.html { redirect_to new_report_path, notice: 'Download complete.' }
                format.json { render :new, status: :ok, location: new_report_path }
            end
        rescue
            redirect_to new_report_path, notice: "Download failed."
        end
    end

    def report_params
        params.require(:report).permit(:mhomename,:mhomeid, :dstart, :dend, :id)
    end

end
