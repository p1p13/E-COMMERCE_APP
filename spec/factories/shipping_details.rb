FactoryGirl.define do
  factory :shipping_detail do |f|
    f.address_line1 "TOWER 61"
    f.address_line2 "1ST FLOOR"
    f.address_line3 "TECHRACERS"
    f.zip "854105"
    f.country "India"
    f.state "MP"
  end
end
