def stock_picker(stocks)
  stocks = stocks.split().map { |num| num.to_i}
  max_profit = 0
  best_days = [0, 0]

  stocks.each_with_index do |buy_price, buy_day|
    stocks[buy_day +1..-1].each_with_index do |sell_price, offset|
      sell_day = buy_day + 1 + offset
      profit = sell_price - buy_price

      if profit > max_profit
        max_profit = profit
        best_days = [buy_day, sell_day]
      end
    end
  end

  return best_days
end

print "Type the stocks (with space between): "
stocks = gets.chomp

p stock_picker(stocks)