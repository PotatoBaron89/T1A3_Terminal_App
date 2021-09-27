
# Documentation needed
module ContentController
  CACHE = {
    words_en: lambda { |array|
      res = array.map { |arr|
        arr[0] }
      return res
    },
    words_fr: lambda { |array|

      res = array.map do |arr|
        key = arr[0]

        {
          type: arr[1]['type'],
          word: arr[1]['translation'],
          gender: arr[1]['gender']
        }

      end

      return res
    }
  }.freeze


end


#word: array.map { |arr| arr[arr.keys[0]][1]['translation'] }