require './paack_cli_helper.rb'

localidad = 1381
provider = 'el-tiempo'

outcome = Weather::GetWeatherSummary.run!(
    city_id: localidad,
    provider: provider
)

puts "### El Tiempo: Gava"
puts ""
puts "## Week Info: #{outcome[:week][:temp][:av_max]}"
puts "Max Tem Av: #{outcome[:week][:temp][:av_min]}"
puts "Min Tem Av: #{outcome[:today][:max]}"
puts ""
puts "## ToDay Info"
puts "Max Tem: #{outcome[:today][:max]}"
puts "Min Tem: #{outcome[:today][:min]}"
puts "Av. Tem: #{outcome[:today][:av]}"
