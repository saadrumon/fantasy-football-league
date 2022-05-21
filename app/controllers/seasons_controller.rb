class SeasonsController < ApplicationController
  before_action :set_season, only: %i[ show edit update destroy close manage_team ]

  # GET /seasons or /seasons.json
  def index
    @seasons = Season.all
  end

  # GET /seasons/1 or /seasons/1.json
  def show
  end

  # GET /seasons/new
  def new
    @season = Season.new
  end

  # GET /seasons/1/edit
  def edit
  end

  # POST /seasons or /seasons.json
  def create
    @season = Season.new(season_params)
    @season.status = Season::RUNNING

    running_season = false
    if Season.last.present? && Season.last.running?
      running_season = true
    end

    respond_to do |format|
      if running_season
        format.html { redirect_to seasons_path, error: "A season is already running." }
      elsif @season.save
        format.html { redirect_to manage_team_season_url(@season), notice: "Season was successfully created." }
        format.json { render :manage_team, status: :created, location: @season }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @season.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /seasons/1 or /seasons/1.json
  def update
    respond_to do |format|
      if @season.update(season_params)
        format.html { redirect_to season_url(@season), notice: "Season was successfully updated." }
        format.json { render :show, status: :ok, location: @season }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @season.errors, status: :unprocessable_entity }
      end
    end
  end

  def manage_team
    if request.post?
      team = Team.find_by(name: params[:team])
      goalkeeper = Player.find(params[:goalkeeper])
      defender = Player.find(params[:defender])
      midfielder = Player.find(params[:midfielder])
      striker = Player.find(params[:striker])
      goalkeeper.team = team
      defender.team = team
      midfielder.team = team
      striker.team = team
      goalkeeper.save!
      defender.save!
      midfielder.save!
      striker.save!
      team.is_locked = true
      team.save!

      all_team_locked = true
      Team.all.each do |team|
        unless team.is_locked?
          all_team_locked = false
        end
      end
  
      @season.is_team_managed = all_team_locked
      @season.save!
    else
      if @season.ended?
        flash[:error] = "Season already ended."
        redirect_to seasons_path
      end

      messages = ""
      messages += "Please create #{Team.all.count - Player.Goalkeeper.count} goalkeeper(s)<br>" if Player.Goalkeeper.count < Team.all.count
      messages += "Please create #{Team.all.count - Player.Defender.count} defenders(s)<br>" if Player.Defender.count < Team.all.count
      messages += "Please create #{Team.all.count - Player.Midfielder.count} midfielder(s)<br>" if Player.Midfielder.count < Team.all.count
      messages += "Please create #{Team.all.count - Player.Striker.count} striker(s)" if Player.Striker.count < Team.all.count
      unless messages.empty?
        flash[:error] = messages.html_safe
        redirect_to seasons_path
      end
    end
  end

  def close
    @season.status = Season::ENDED
    @season.save!

    Team.all.each do |team|
      team.is_locked = false
      team.save!
    end

    Player.all.each do |player|
      player.team = nil
      player.save!
    end

    redirect_to seasons_path
  end

  # DELETE /seasons/1 or /seasons/1.json
  def destroy
    @season.destroy

    respond_to do |format|
      format.html { redirect_to seasons_url, notice: "Season was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_season
      @season = Season.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def season_params
      params.require(:season).permit(
        :title,
        :team,
        :goalkeeper, 
        :defender,
        :midfielder,
        :striker
      )
    end
end
