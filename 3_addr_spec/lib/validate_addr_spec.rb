
class Validation
    def validate(input, output)
        input.read.chomp.split("\n", -1).each do |line|
            validate_line(line, output)
        end
    end

    def validate_domain(domain)
        return false if domain[0] == '.' || domain[-1] == '.'
        return false if domain.index("..")
        return false if domain.length == 0
        match = domain.match(/^[A-Za-z0-9!#$%&'*+-\/=?^_`{|}~.]+$/)
        return false if match.nil?
        true
    end

    def validate_local(local)
        if local[0] == '"' && local[-1] == '"'
            return false if local.length < 2
            match = local.match(/^"[A-Za-z0-9!#$%&'*+-\/=?^_`{|}~(),.:;<>@\[\]"\\]*"$/)
            return false if match.nil?
            true
        else
            validate_domain(local)
        end
    end

    def validate_line(line, output)
        local_domain = line.split('@')
        local = local_domain[0..-2].join('@')
        domain = local_domain[-1]
        if !local || !domain
            output.puts "ng"
            return
        end
        if validate_domain(domain) && validate_local(local)
            output.puts 'ok'
        else
            output.puts 'ng'
        end
    end
end

if __FILE__ == $0
    valid = Validation.new
    valid.validate(STDIN, STDOUT)
end