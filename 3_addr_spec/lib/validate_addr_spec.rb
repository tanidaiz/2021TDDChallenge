
class Validation
    def validate(input, output)
        input.read.chomp.split("\n", -1).each do |line|
            validate_line(line, output)
        end
    end

    def validate_line(line, output)
        output.puts 'ok'
    end
end