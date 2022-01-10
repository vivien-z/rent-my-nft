require "open-uri"
require 'faker'

puts "destroying records..."
User.destroy_all
Nft.destroy_all
Reservation.destroy_all

puts "start seeding..."

# users----------------------------------------------------------------
nana = User.create!(email: "nana@test.com" , password: "123456")
yaki = User.create!(email: "yaki@test.com" , password: "123456")
puts "created users"

# nft------------------------------------------------------------------

# images
img_1 = URI.open("https://res.cloudinary.com/vivienz/image/upload/v1641778350/development/rghnrdcls3enu8js0bh6y26w7tv7.jpg")
img_2 = URI.open("https://res.cloudinary.com/vivienz/image/upload/v1641778118/development/7re9xxpwve9ctlj3kdn9yp1zyod4.jpg")
img_3 = URI.open("https://res.cloudinary.com/vivienz/image/upload/v1641778094/development/4q50trofw1h7yd4hbdqxkase8pp9.jpg")
img_4 = URI.open("https://res.cloudinary.com/vivienz/image/upload/v1641777993/development/t94zhwn1ziv6u40e8x01y3m02t92.jpg")
img_5 = URI.open("https://res.cloudinary.com/vivienz/image/upload/v1641777928/development/yrvs1mutwcfmihlvtu5hqc1nz6me.jpg")
img_6 = URI.open("https://res.cloudinary.com/vivienz/image/upload/v1641777880/development/orgl3v0ogd7j17cnz4lrxvk8tnsk.jpg")
img_7 = URI.open("https://res.cloudinary.com/vivienz/image/upload/v1641777811/development/n3te4v1szrh9bz6ymrh6gjtfgayd.jpg")
imgs = [img_1, img_2, img_3, img_4, img_5, img_6, img_7]

# addresses
add_1 = "690 Rue Sherbrooke Ouest, Montreal, QC"
add_2 = "120 Rue Peel, Montreal, QC"
add_3 = "110 Rue Notre Dame Ouest, Montreal, QC"
add_4 = "195 Rue Young, Montreal, QC"
add_5 = "138 Avenue Atwater, Montreal, QC"
add_6 = "350 Rue Saint-Paul Est, Montreal, QC"
add_7 = "3415 Rue Saint-Urbain, Montreal, QC"
addresses = [add_1, add_2, add_3, add_4, add_5, add_6, add_7]

# nfts
imgs.each_with_index do |img, i|
  nft = Nft.new(
            name: Faker::Name.last_name,
            price: Faker::Number.decimal(l_digits: 3, r_digits: 2),
            address: addresses[i],
            description: Faker::Quotes::Shakespeare.as_you_like_it_quote)
  nft.image.attach(io: imgs[i], filename: "#{nft.name}.jpg", content_type: 'image/jpg')
  (i < 4) ? nft.user = nana : nft.user = yaki
  nft.save!
end
puts "created nft listings"

# reservation---------------------------------------------------------------
reservation_1 = Reservation.new(starting_date: "2022-01-10", ending_date: "2022-01-12")
reservation_1.nft = Nft.offset(4).first
reservation_1.user = nana
reservation_1.save!

reservation_2 = Reservation.new(starting_date: "2022-02-03", ending_date: "2022-02-04")
reservation_2.nft = Nft.offset(4).second
reservation_2.user = nana
reservation_2.save!

reservation_3 = Reservation.new(starting_date: "2022-01-22", ending_date: "2022-01-25")
reservation_3.nft = Nft.first
reservation_3.user = yaki
reservation_3.save!
puts "created reservations"

puts "finish seeding..."
