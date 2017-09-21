FactoryGirl.define do
  factory :user do |f|
    f.email "p1p13@coldmail.com"
    f.password "qwert"
  end

  factory :invalid_user, parent: :user do |f|
    f.email nil
  end

end
