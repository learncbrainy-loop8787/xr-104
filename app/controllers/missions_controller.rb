class MissionsController < ApplicationController
    before_action :find_mission, only: [:show, :edit, :update, :destroy]



   

    def show
        if !@mission
            
            flash[:notice] = "Mission does not exist."
            render plain: flash[:notice]
        end
    end

    def create
        if @mission = Mission.find_by(user_id: @current_user.id, soldier_id: params[:mission][:soldier_id]) 
            flash["alert alert-info"] = "Soldier already has his orders."
            redirect_to user_soldier_path(@mission.soldier.general_name, @mission.soldier)
        else
            @mission = Mission.new(mission_params)
            if @mission.save
            redirect_to user_soldier_path(@mission.soldier.general_name, @mission.soldier)
            else
                flash["alert alert-danger"] = "Objective's can't be blank"
                redirect_to user_soldier_path(@mission.soldier.general_name, @mission.soldier)
            end
        end
    end

    def edit
        
        if @mission.user_id != @current_user.id
          redirect_to soldiers_path
        end
    end

    def update
        @mission.update(mission_params)

        redirect_to mission_path( @mission)
    end

    def destroy
        @mission.delete

        redirect_to user_soldier_path(@mission.soldier.general_name, @mission.soldier)
    end

    private

    def mission_params
        params.require(:mission).permit(:importances, :objectives, :soldier_id, :user_id)
    end

    def find_mission
        @mission = Mission.find_by(id: params[:id])
    end

end
