namespace :aggregations do
  SpiderService::VALID_SPIDERS.each do |spider|
    desc "Run #{spider}"
    task spider.name.underscore do
      SpiderService.call spider
    end
  end
end
