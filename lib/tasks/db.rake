namespace :db do
  desc "Push current database state to server"
  task :push do
    require "uri"
    
    database = "powers_development"
    
    puts "Dumping local database..."
    `~/src/mongo/bin/mongodump -d #{database}`

    File.unlink "dump/#{database}/system.indexes.bson"
    File.unlink "dump/#{database}/system.users.bson"
    
    config = Hash[*`heroku config`.split("\n").map { |line| line.split(/\s*=>\s*/) }.flatten]
    mongo = URI.parse config["MONGOLAB_URI"]

    puts "Pushing to #{mongo.host}..."
    `~/src/mongo/bin/mongorestore -h #{mongo.host} --port #{mongo.port} -u #{mongo.user} -p #{mongo.password} -d #{mongo.path.sub /^\//, ""} --drop dump/#{database}`
    
    puts "Cleaning up..."
    `rm -r dump`
    
    puts "Finished"
  end
end