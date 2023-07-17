module RatingHelper
  def star_rating_class(product, current_user, star)
    if star.to_i < Review.find_by(product: product, user: current_user)&.rating.to_i
      "fill-yellow-400 stroke-yellow-400" 
    else
      "fill-transparent stroke-gray-400" 
    end
  end
end

# select  product_id,
# (select  count(rating) from reviews where product_id='6' and rating='5' ) as rating_5, 
# (select  count(rating)  from reviews where product_id='6' and rating='4' ) as rating_4, 
# (select  count(rating)  from reviews where product_id='6' and rating='3' ) as rating_3,
# (select   count(rating)  from reviews where product_id='6' and rating='2' ) as rating_2,
# (select count(rating)  from reviews where product_id='6' and rating='1' ) as rating_1
# from reviews  where product_id='6' group by product_id;




