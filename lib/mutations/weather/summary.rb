class Weather::Summary < Mutations::Command

  required do
    hash :week do
      array :tempmaxs, class: Numeric, min_length: 1
      array :tempmins, class: Numeric, min_length: 1
    end
    hash :today do
      array :tempmaxs, class: Numeric, min_length: 1
      array :tempmins, class: Numeric, min_length: 1
    end
  end

  def execute
    {
        week: {
            temp: {
                av_max: av_temp(week[:tempmaxs]),
                av_min: av_temp(week[:tempmins])
            }
        },
        today: {
            max: today[:tempmaxs].first,
            min: today[:tempmins].first,
            av: av_temp(today_temps)
        }
    }
  end

  private

  def av_temp(numbers)
    DataScience::Mean.run!(numbers: numbers)
  end

  def today_temps
    today.flat_map { |_, value| value }
  end
end
