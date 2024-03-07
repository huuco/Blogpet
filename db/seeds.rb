# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

5.times do |i|
  Product.create(
    name: Faker::Book.title,
    description: Faker::Quotes::Shakespeare.hamlet_quote,
    quantity: (1..100).to_a.sample,
    price: (40..100).to_a.sample
  )
end
# ["Cuộc chiến tiền tệ", 
# "Lý thuyết trò chơi", 
# "Trí tuệ Do Thái", 
# "Tâm và kế người Do Thái", 
# "Người bán hàng vĩ đại nhất thế giới",
# "10 Bí quyết thành công của người Do Thái",
# "Câu chuyện Do Thái – Lịch Sử Thăng Trầm Của Dân Tộc",
# " Dân tộc được Chúa chọn",
# "Dẫn luận về Do Thái giáo",
# "Miền đất hứa của tôi – Khải hoàn và bi kịch của Israel",
# " Israel – mảnh đất của những phát minh vì con người"]