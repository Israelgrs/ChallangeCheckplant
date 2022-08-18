class NoodlesController < ApplicationController
  before_action :validate_times_sent, only: %i[calculate]

  def index
    @noodle = OpenStruct.new

    respond_to do |format|
      format.html { render :calculate }
    end
  end

  def calculate
    @noodle = OpenStruct.new
    @result = CalculateService.get_time(calculate_params)
    respond_to do |format|
      format.html
    end
  end

  private

  def validate_times_sent
    return unless request.method == 'POST'
    return redirect_to root_path, notice: I18n.t('noodles.calculate_required_param', param: 'Tempo da primeira Ampulheta') if params[:calculate][:first_hourglass].blank?
    return redirect_to root_path, notice: I18n.t('noodles.calculate_required_param', param: 'Tempo da segunda Ampulheta') if params[:calculate][:second_hourglass].blank?
    return redirect_to root_path, notice: I18n.t('noodles.calculate_required_param', param: 'Tempo de cozimento') if params[:calculate][:time_to_cook].blank?
    return redirect_to root_path, notice: I18n.t('noodles.time_cant_be_the_same') if params[:calculate][:first_hourglass] == params[:calculate][:second_hourglass] && params[:calculate][:first_hourglass] > params[:calculate][:time_to_cook]
  end

  def calculate_params
    params.require(:calculate).permit(:first_hourglass, :second_hourglass, :time_to_cook)
  end
end