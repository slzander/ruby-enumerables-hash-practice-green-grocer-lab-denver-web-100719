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
  cart.each do |n|
    food = n.keys[0]
    
    if cart[food][:clearance] == true
      cart[food][:price] *= 0.8
    else
      
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
end







