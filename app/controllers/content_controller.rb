
# Documentation needed
module ContentController
  CACHE = {

    # Specifcally for pulling vocab from lessons
    get_word_object: lambda { |array|
      res = array.map do |arr|
        {
          english: arr[:english],
          translation: arr[:translation],
          type: arr[:type],
          gender: arr[:gender]
        }
      end

      return res
    }
  }.freeze


end


#word: array.map { |arr| arr[arr.keys[0]][1]['translation'] }