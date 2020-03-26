require 'factory_bot'

FactoryBot.define do

  factory :data, class: Hash do
    skip_create
    week do
      {
          :tempmins=>[9, 11, 11, 8, 7],
          :tempmaxs=>[20, 14, 23, 10, 9]
      }
    end
    today { {:tempmins=>[9], :tempmaxs=>[20]} }

    initialize_with do
      attributes.
          with_indifferent_access.
          deep_symbolize_keys
    end
  end

  factory :cooked_data, class: Hash do
    skip_create
    week do
      {
          :temp => {
              :av_max => 15.2,
              :av_min => 9.2
          }
      }
    end
    today { {:max=>20, :min=>9, :av => 14.5 } }
    initialize_with do
      attributes.
          with_indifferent_access.
          deep_symbolize_keys
    end
  end
end
