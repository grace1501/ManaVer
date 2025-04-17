desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do
  if Rails.env.development?
    Version.destroy_all
    Folder.destroy_all
    User.destroy_all
  end

  p "Creating sample data..."

  usernames = ["alice", "bob", "eve"]

  users = []
  folders = []

  # Creating sample users
  usernames.each do |username|
    user = User.new
    user.username = username
    user.email = "#{username}@example.com"
    user.password = "password"
    user.save
    users.push(user)
  end

  10.times do 
      folder = Folder.new
      folder.name = Faker::Book.genre
      folder.save

      versions = []
      rand(2..5).times do
        version = Version.new
        version.name = Faker::Book.title
        version.description = Faker::Quote.famous_last_words
        version.folder_id = folder.id
        version.user_id = users.sample().id
        version.save
      end

    end


  p "Finished task. Created #{User.count} users, #{Folder.count} folders, and #{Version.count} versions."
end
