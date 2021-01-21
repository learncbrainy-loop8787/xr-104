class SoldiersController < ApplicationController
    skip_before_action :require_login, except: [:index, :show]
    before_action :require_general, only: [:new, :create, :edit, :update, :destroy]
    before_action :set_soldier, only: [:show]
    before_action :set_general_soldier, only: [:edit, :update]
    
    def index

        if params[:user_id]
            @user = User.find(params[:user_id]) if params[:user_id]
            @soldiers = @user.soldiers.sorted_asc
          else 
          @soldiers = Soldier.all
          end  
    end

    def new
        @soldier = Soldier.new
    end

    def create
        @soldier = @current_user.soldiers.build soldier_params
        if @soldier.save
            flash["alert alert-info"] = "Hey a new recruit!"
            redirect_to soldiers_path
        else
            render :new
        end
    end

    def top_ten
        @soldiers = Soldier.sort_by_name.limit(10)
        render :index
    end

    def top_kills
        @soldiers = Soldier.sort_by_kills.limit(10)
      
       
    end 

    def show
        if !@soldier
            @soldier = Soldier.find(params[:id])
          flash["alert alert-danger"] = "No soldier."
        
          redirect_to soldiers_path
        end
        @mission = @soldier.missions.build(user_id: @current_user.id)
    end

    def edit
        if !@soldier
          flash["alert alert-danger"] = "This soldier isn't yours."
        
          redirect_to soldiers_path
        end
    end

    def update
        if @soldier.update(soldier_params)
            flash["alert alert-success"] = "Soldier has been edited."
            redirect_to soldier_path
        else
            render :edit
        end
    end

    def destroy
        @soldier = Soldier.find(params[:id])
        
       @soldier.destroy

        flash["alert alert-dark"] = "Soldier successfully removed."
        redirect_to soldiers_path
    end

   

    private

    def set_soldier
        @soldier = Soldier.find_by(id: params[:id])
    end

    def set_general_soldier
        @soldier = @current_user.soldiers.find_by(id: params[:id])
    end

    def soldier_params
        params.require(:soldier).permit( 
            :name, 
            :social_security, 
            :confirmed_kills, 
            :resume,
            :combat_experience
        )
    end
end
