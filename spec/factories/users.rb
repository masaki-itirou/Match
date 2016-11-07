FactoryGirl.define do
  factory :user do
    sequence(:name){|i| "user#{i}"}
    #password = r
    sequence(:password){"a882f0ac848b0b6b4ca7b42bfa1d266afd0ddeba9204ae57a984a69376d59816b1ef3f4d442ea8a70396067ff5b70e0ae8eab3935b617b8e366d8e35c3bfe14c"}
  end
end


