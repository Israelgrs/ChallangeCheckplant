class DistancesController < ApplicationController
  before_action :validate_coordinates, only: %i[calculate]

  def index
    @coordinate = OpenStruct.new

    respond_to do |format|
      format.html { render :calculate }
    end
  end

  def calculate
    @coordinate = OpenStruct.new
    @distance = DistanceService.get_distance(calculate_params)

    respond_to do |format|
      format.html
    end
  end

  private

  def validate_coordinates
    return unless request.method == 'POST'
    return redirect_to root_path, notice: I18n.t('noodles.calculate_required_param', param: 'Latitude da primeiras coordenadas') if params[:calculate][:first_coordinate_lat].blank?
    return redirect_to root_path, notice: I18n.t('noodles.calculate_required_param', param: 'Longitude das primeiras coordenadas') if params[:calculate][:first_coordinate_long].blank?
    return redirect_to root_path, notice: I18n.t('noodles.calculate_required_param', param: 'Latitude das segundas coordenadas') if params[:calculate][:second_coordinate_lat].blank?
    return redirect_to root_path, notice: I18n.t('noodles.calculate_required_param', param: 'Longitude das segundas coordenadas') if params[:calculate][:second_coordinate_long].blank?
  end

  def calculate_params
    params.require(:calculate).permit(:first_coordinate_lat, :first_coordinate_long, :second_coordinate_lat, :second_coordinate_long)
  end
end