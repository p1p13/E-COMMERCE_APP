FactoryGirl.define do
  factory :product do |f|
    f.title "HP"
    f.description "with wifi"
    f.in_stock 80
    f.cost 800
  end
end
