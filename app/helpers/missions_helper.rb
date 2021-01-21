#A helper is a method that is (mostly) used in your Rails views to share reusable code. Rails comes with a set of built-in helper methods.


module MissionsHelper
    def danger_levels(effectivness)
        case effectivness
        when 10
            "!""!""!""!""!""!""!""!""!""!"
        when 9
            "!""!""!""!""!""!""!""!""!"
        when 8
            "!""!""!""!""!""!""!""!"
        when 7
            "!""!""!""!""!""!""!"
        when 6 
            "!""!""!""!""!""!""!"
        when 5
            "!""!""!""!""!"
        when 4
            "!""!""!""!"
        when 3
            "!""!""!"
        when 2
            "!""!"
        when 1
            "!"
        else
        "Rank Severity of Mission!"
        end
    end

 
end
