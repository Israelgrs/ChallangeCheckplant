class CalculateService
  attr_accessor :first_hourglass, :second_hourglass, :time_to_cook

  def self.get_time(calculate_params)
    return calculate_params[:time_to_cook] if calculate_params[:first_hourglass] == calculate_params[:time_to_cook] || calculate_params[:second_hourglass] == calculate_params[:time_to_cook]
    return calculate_params[:time_to_cook] if calculate_params[:first_hourglass].to_i + calculate_params[:second_hourglass].to_i == calculate_params[:time_to_cook].to_i

    first = calculate_params[:first_hourglass]
    second = calculate_params[:second_hourglass]
    time = calculate_params[:time_to_cook]

    hourglass_time = [first.to_i, second.to_i].minmax
    time_sum = hourglass_time.clone

    begin
      Timeout.timeout(5) do
        while (time_sum.max - time_sum.min) != time.to_i do
          if time_sum.first < time_sum.last
            time_sum[0] = time_sum.first + hourglass_time.first
          elsif time_sum.first > time_sum.last
            time_sum[1] = time_sum.last + hourglass_time.last
          else
            if (time.to_i % hourglass_time.min).zero? ||
               (time.to_i % hourglass_time.max).zero?
              return self.resultado = time.to_i
            end

            return 'Não é possível realizar o calculo'
          end

          if time_sum.min == time.to_i
            return  time_sum.min
          end

        end
      end
    rescue Timeout::Error
      raise 'Tempo de processamento excedido.'
    end

    time_sum.max
  end
end