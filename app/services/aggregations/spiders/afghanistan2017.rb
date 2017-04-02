class Afghanistan2017 < Spidey::AbstractSpider

  handle 'https://www.thebureauinvestigates.com/drone-war/data/' \
    'get-the-data-a-list-of-us-air-and-drone-strikes-afghanistan-2017', :process_home


  def process_home(page, default_data = {})
    page.search('.tb-c-drone-data-strike').each do |section|
      data = process_drone_strike section
      clean = clean data
      record default_data.merge(data)
    end
  end


  def process_drone_strike(content)
    name = content.search('.tb-c-drone-data-strike__heading').first&.text
    date = content.search('.tb-c-drone-data-strike__date').first&.text
    stats = content.search('.tb-c-stats-list__item').map(&:text).join('; ')
    body = content.search('.tb-c-story-text-block').first
    description = body.search('p').map(&:text).join('\n')&.strip
    list_items = body.search('li')
    type = list_items[0]&.text if list_items.count > 0
    location = list_items[1]&.text if list_items.count > 1
    references = list_items[2]&.text if list_items.count > 2
    { 
      name: name,
      date: date,
      stats: stats,
      description: description,
      type: type,
      location: location,
      references: references
    }
  end

  def clean(data)
    data[:name] = data[:name]&.gsub('link', '')&.strip
    data[:type] = data[:type]&.gsub('Type of strike:', '')&.strip
    data[:location] = data[:location]&.gsub('Location:', '')&.strip&.split(', ')&.last
    data[:references] = data[:references]&.gsub('References:', '')&.strip
    stats = data[:stats]&.split('; ')
    killed = stats.find { |s| s =~ /killed/ }
    data[:killed] = killed.split(' ').first if killed
    injured = stats.find { |s| s =~ /injured/ }
    data[:injured] = injured.split(' ').first if injured
    wounded = stats.find { |s| s =~ /injured/ }
    data[:wounded] = wounded.split(' ').first if wounded
    data.delete(:stats)
    data
  end
end
