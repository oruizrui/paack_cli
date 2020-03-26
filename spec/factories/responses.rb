require 'factory_bot'
require 'json'

FactoryBot.define do

  factory :api_response, class: Hash do
    skip_create
    code { 200 }
    body { create(:body).to_json }
    initialize_with do
      attributes.
          with_indifferent_access.
          stringify_keys
    end
  end

  factory :body, class: Hash do
    skip_create

    status { 0 }
    location { "Gavà [Provincia de Barcelona;España]" }
    url { "https://www.tiempo.com/gava.htm" }
    day do
      {
          :"1"=>{:tempmin=>"9", :tempmax=>"20"},
          :"2"=>{:tempmin=>"11", :tempmax=>"14"},
          :"3"=>{:tempmin=>"11", :tempmax=>"23"},
          :"4"=>{:tempmin=>"8", :tempmax=>"10"},
          :"5"=>{:tempmin=>"7", :tempmax=>"9"}
      }
    end

    initialize_with do
      attributes.
          with_indifferent_access.
          stringify_keys
    end
  end

  factory :wrong, class: Hash do
    skip_create
    initialize_with do
      attributes.
          with_indifferent_access.
          stringify_keys
    end

    trait :localidad do
      status { 1 }
      error { "La localidad a la que intentas acceder no existe." }
    end

    trait :affiliate do
      status { 1 }
      error { "Usted no està registrado como usuario de la API de tiempo.com o su cuenta no està activada." }
    end
  end
end
