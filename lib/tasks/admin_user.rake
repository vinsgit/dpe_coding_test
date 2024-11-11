namespace :admin_user do
  desc "This is a simple task"
  task :create, [:password]  => :environment do |task, args|
    if args[:password].blank? || args[:password].length < 6
      puts 'Password must be more than 6 strings!'
    else
      User.create(username: 'admin', password: args[:password])
    end
  end
end