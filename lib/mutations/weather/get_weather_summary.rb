class Weather::GetWeatherSummary < Mutations::Command

  required do
    integer :city_id
    string :provider, in: ['el-tiempo']
  end

  def execute
    case provider
    when 'el-tiempo' then Weather::GetSummary.run!(localidad: city_id)
    end
  end
end
