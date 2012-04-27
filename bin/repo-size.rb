#! /usr/bin/env ruby
require 'erb'

hash = eval `/Users/andreas/code/privat/git-metrics/bin/repo-size.sh`

dates = []
number_of_lines = []

hash.sort.each do |pair|

  dates << pair[0]
  number_of_lines << pair[1].to_i

end
values = number_of_lines
labels = dates
template = ERB.new(File.read("/Users/andreas/code/privat/git-metrics/bin/repo_size_template.html.erb"))

outputFile = File.new("repo-size.html",File::CREAT|File::TRUNC|File::RDWR)
outputFile.write(template.result)
outputFile.close
