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
  hash_cart = apply_coupons(hash_cart, coupons)
  hash_cart = apply_clearance(hash_cart)
  
  total_cost = hash_cart.reduce(0) { |memo, (key, value)| memo += value[:price] * value[:count]}
  
  total_cost *= 0.9 if total_cost >= 100
  total_cost 
end

