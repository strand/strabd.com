module Base60
  # See link below for specifications of this Base60.
  # http://tantek.pbworks.com/w/page/19402946/NewBase60
  # Based off of the Base62 gem (link below)
  # https://github.com/jtzemp/base62/blob/master/lib/base62.rb

  PRIMITIVES = ('0'..'9').to_a + ('A'..'H').to_a + ('J'..'N').to_a +
               ('P'..'Z').to_a + ["_"] + ('a'..'k').to_a + ('m'..'z').to_a

  class << self
    def decode(string)
      if (string.split("") - PRIMITIVES).length != 0
        raise ArgumentError, "Base60 can't decode this string."
      else
        decode_base60_string string
      end
    end

    def encode(integer)
      if integer < 0
        raise ArgumentError, "Base60 can't encode negative numbers."
      elsif integer == 0
        "0"
      else
        encode_positive_integer integer
      end
    end

    private
    def encode_positive_integer(integer)
      result = ''
      while integer > 0
        result.prepend PRIMITIVES[integer % PRIMITIVES.size]
        integer /= PRIMITIVES.size
      end
      result
    end

    def decode_base60_string(string)
      output = 0
      string.chars.reverse.each_with_index do |character, index|
        place = PRIMITIVES.size ** index
        output += PRIMITIVES.index(character) * place
      end
      output
    end
  end
end