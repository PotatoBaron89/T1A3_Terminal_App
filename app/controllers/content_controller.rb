
# Documentation needed
module ContentController
  CACHE = {
    words_en: lambda { |array|
      res = array.map { |arr| arr.keys }
      return res
    },
    words_fr: lambda { |array|

      res = array.map do |arr|
        key = arr.keys[0]
        {
          type: arr[key][0]['type'],
          word: arr[key][1]['translation'],
          gender: arr[key][2]['gender']
        }
      end
      return res
    }
  }.freeze


end


#word: array.map { |arr| arr[arr.keys[0]][1]['translation'] }