class Weather::PrepareData < Mutations::Command

  DAYS = %w[1 2 3 4 5]

  required do
    integer :status, in: [0, 1]
  end

  optional do
    string :location, discard_empty: true
    string :url, discard_empty: true
    hash :day, discard_empty: true do
      required do
        DAYS.each do |day|
          hash :"#{day}" do
            required do
              integer :tempmin
              integer :tempmax
            end
          end
        end
      end
    end

    string :error, discard_empty: true
  end

  def validate
    validate_consisntecy
    validate_only_status_zero unless has_errors?
  end

  def execute
    DAYS.each_with_object(result_hash) do |str, hash|
      hash[:week][:tempmins] << day[:"#{str}"][:tempmin].to_i
      hash[:week][:tempmaxs] << day[:"#{str}"][:tempmax].to_i

      if str == '1'
        hash[:today][:tempmins] << day[:"#{str}"][:tempmin].to_i
        hash[:today][:tempmaxs] << day[:"#{str}"][:tempmax].to_i
      end
    end
  end

  private

  def validate_consisntecy
    if status === 0
      if location.nil? || url.nil?  || day.nil?
        add_error(:data, :missing, 'Wrong data consisntecy. Data is invalid.')
      end
    elsif status === 1
      if error.nil?
        add_error(:data, :missing, 'Wrong data consisntecy. Data is invalid.')
      end
    end
  end

  def validate_only_status_zero
    if status != 0
      add_error(:data, :invalid, error)
    end
  end

  def result_hash
    {
        week: {
            tempmins: [],
            tempmaxs: []
        },
        today: {
            tempmins: [],
            tempmaxs: []
        }
    }
  end
end
