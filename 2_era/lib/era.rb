
class Era
    # 元号変換ロジック
    #
    # @param year [Integer] 西暦
    # @param month [Integer] 月(1〜12)
    # @param day [Integer] 日(1〜31)
    # @return [String] 元号変換後の文字列 ex) "平成10年"
    def calc(year, month, day)
        date = Time.new(year, month, day)
        case date
        when nil..Time.new(1926, 12, 24)
            raise ArgumentError
        when Time.new(1926, 12, 25)..Time.new(1989, 1, 7)
            if date <= Time.new(1926, 12, 31)
                "昭和元年"
            else
                "昭和#{(year - 1925).to_s}年"
            end
        when Time.new(1989, 1, 8)..Time.new(2019, 4, 30)
            if date <= Time.new(1989, 12, 31)
                "平成元年"
            else
                "平成#{(year - 1988).to_s}年"
            end
        when Time.new(2019, 5, 1)..nil
            if date <= Time.new(2019, 12, 31)
                "令和元年"
            else
                "令和#{(year - 2018).to_s}年"
            end
        end
    end
end