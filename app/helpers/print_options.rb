def print_options(prompt, *options)
  print prompt + options.join(' ').colorize(:yellow)
  puts '?'
end
