namespace :print do
  desc 'puts 1 to 5 in a sequence'
  task puts_until5: %i[puts1 puts2 puts3 puts4 puts5] do
    puts 'Sequence complete'
  end

  task :puts1 do
    puts 1
  end

  task :puts2 do
    puts 2
  end

  task :puts3 do
    puts 3
  end

  task :puts4 do
    puts 4
  end

  task :puts5 do
    puts 5
  end
end
