class DistanceService
  attr_accessor :first_hourglass, :second_hourglass, :time_to_cook

  def self.get_distance(calculate_params)
    lat_diff = convert(calculate_params[:first_coordinate_lat], calculate_params[:second_coordinate_lat])
    long_diff = convert(calculate_params[:first_coordinate_long], calculate_params[:second_coordinate_long])
    diff = lat_diff**2 + long_diff**2
    distance = Math.sqrt(diff).round(1)

    distance
  end

  def self.convert(first, second)
    graus = first.split("°")[0].gsub(",",".").to_f - second.split('°')[0].gsub(",",".").to_f
    min = first.split("°")[1].split("’")[0].gsub(",",".").to_f - second.split("°")[1].split("’")[0].gsub(",",".").to_f
    sec = first.split("°")[1].split("’")[1].gsub(",",".").to_f - second.split("°")[1].split("’")[1].gsub(",",".").to_f

    distance = (((graus * 60) + min + (sec / 60)) * 1.852) * 1000
    converted_value = distance.round(1)
    converted_value
  end
end