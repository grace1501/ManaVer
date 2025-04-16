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
  
  # Creating sample users
  usernames.each do |username|
    user = User.new
    user.username = username
    user.email = "#{username}@example.com"
    user.password = "password"
    user.save
    users.push(user)
  end
  
  # Creating samle folders, multiple sample versions that belongs to each folder, and assign one default version for each folder
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

        versions.push(version)
      end

      folder.default_version = versions.sample()
      folder.save

    end

  p "Finished task. Created #{User.count} users, #{Folder.count} folders, and #{Version.count} versions."
end
