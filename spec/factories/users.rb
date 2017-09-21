FactoryGirl.define do
  factory :user do |f|
    f.email "p1p13@coldmail.com"
    f.password "qwert"
  end

  factory :invalid_user, parent: :user do |f|
    f.email nil
  end

  factory :valid_user, parent: :user do |f|
    f.contact_number "57565"
    f.country_code "+91"
  end

end
