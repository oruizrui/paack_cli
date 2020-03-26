class Weather::ApiCallback < Mutations::Command

  required do
    integer :code, class: Integer
    duck :body
  end

  def validate
    validate_json
  end

  def execute
    parsed_body
  end

  private

  def validate_json
    unless parsed_body
      add_error(:body, :invalid, "Must be a valid JSON.")
    end
  end

  def parsed_body
    begin
      JSON.parse(body, {:symbolize_names => true})
    rescue => e
      false
    end
  end
end
