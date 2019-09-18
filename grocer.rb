require 'pry'

def consolidate_cart(cart)
  hash = {}
  cart.each do |n|
    food = n.keys[0]

    if hash.has_key?(food)
      hash[food][:count] += 1 
    else
      hash[food] = {
        count: 1,
        price: n[food][:price],
        clearance: n[food][:clearance]
      }
    end
  end
  hash
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item = coupon[:item]
    if cart[item]
      if cart[item][:count] >= coupon[:num] && !cart.has_key?("#{item} W/COUPON") 
        cart["#{item} W/COUPON"] = {price: coupon[:cost] / coupon[:num], clearance: cart[item][:clearance], count: coupon[:num]}
        cart[item][:count] -= coupon[:num]
      elsif cart[item][:count] >= coupon[:num] && cart.has_key?("#{item} W/COUPON")
        cart["#{item} W/COUPON"][:count] += coupon[:num]
        cart[item][:count] -= coupon[:num]
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |food, details|
    details[:price] -= details[:price] * 0.2 if details[:clearance]
  end
  cart
end

def checkout(cart, coupons)
  hash_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(hash_cart, coupons)
  discount_cart = apply_clearance(coupon_cart)
  
  total_cost = discount_cart.reduce(0) { |memo, (key, value)| acc += [value][:price] * [value][:count]}
  hash_cart.each do |food, details|
    total_cost += details[:price]
  end 
  total_cost *= 0.9 if total_cost >= 100
  total_cost 
end







