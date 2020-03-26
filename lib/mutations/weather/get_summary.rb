class Weather::GetSummary < Mutations::Command

  required do
    integer :localidad
  end

  def execute
    Weather::ApiCall.run!(localidad: localidad).
        then{ |scope| Weather::ApiCallback.run!(scope) }.
        then{ |scope| Weather::PrepareData.run!(scope) }.
        then{ |scope| Weather::Summary.run!(scope) }
  end

end
