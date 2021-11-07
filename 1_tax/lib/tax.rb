
class Tax
    def calc(prices)
        result = prices.sum
        result *= 1.1
        result = result.round
        return result
    end
end
