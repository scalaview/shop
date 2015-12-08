namespace :region do
  desc 'import region data to database from config/areas.json'
  task :import => :environment do
    puts 'Importing ...'
    file_path = Rails.root.join('config', 'areas.json')
    json = JSON.parse(File.read(file_path))
    regions = json.values.flatten
    Shoppe::Region.delete_all
    load_to_db(regions)
    puts "Regions import done!"
  end

  def load_to_db(regions)
    regions.each do |region|
      code = region['id']
      name = region['text']
      if code.end_with?('0000')
        Shoppe::Region.where(code: code, name: name, level: 1).first_or_create!
      elsif code.end_with?('00')
        Shoppe::Region.where(code: code,parentcode: code[0,2]+'0000', name: name, level: 2).first_or_create!
      else
        Shoppe::Region.where(code: code,parentcode: code[0,4]+'00', name: name, level: 3).first_or_create!
      end
    end
  end
end