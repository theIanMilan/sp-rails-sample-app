namespace :sessions do
  desc 'Delete sessions which have false status caused by expiration'
  task remove_false_status: :environment do
    Session.where(status: false).each do |s|
      s.transaction { s.destroy }
    end
  end
end
