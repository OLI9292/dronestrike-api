module SpiderService

  VALID_SPIDERS = [
    Afghanistan2017
  ].freeze

  class << self

    def base_url
      'https://www.thebureauinvestigates.com/drone-war/data/'
    end

    def call(spider)
      raise 'Invalid spider' unless VALID_SPIDERS.include?(spider)
      spider = spider.new request_interval: 0.5
      spider.crawl
      spider_name = spider.class.name.underscore
      spider_results = spider.results
      if spider_results
        AggregationUploadService.call spider_name, spider_results
      else
        puts "SpiderService -> #{spider_name} failed to return results"
      end
    end
  end
end
