import RegexBuilder

struct Validation {

    static let emailPattern = Regex {
        Capture {
            ZeroOrMore {
                OneOrMore(.word)
                "."
            }
            OneOrMore(.word)
        }
        "@"
        Capture {
            OneOrMore(.word)
            OneOrMore {
                "."
                OneOrMore(.word)
            }
        }
    }
}
