class Weather::ApiCall < Mutations::Command

  BASE_URI = 'http://api.tiempo.com/index.php'
  AFFILIATE_ID = '1k29jcz9flvv'

  required do
    integer :localidad, class: Integer
  end

  optional do
    string :api_lang, default: 'es'
    string :v, default: '3.0'
  end

  def execute
    Request.
        request(
            base_uri: base_uri,
            params: params
        )
  end

  private

  def base_uri
    BASE_URI
  end

  def params
    base_params.
        merge!(inputs).
        symbolize_keys
  end

  def base_params
    {
        affiliate_id: affiliate_id
    }
  end

  def affiliate_id
    AFFILIATE_ID
  end
end
