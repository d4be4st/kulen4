#encoding: UTF-8
class Page
  include ActiveModel::Model
  include PageConstants

  attr_accessor :id
  attr_accessor :content
  attr_accessor :layout
  attr_accessor :layout_full
  attr_accessor :page
  attr_accessor :page_full
  attr_accessor :path
  attr_accessor :head
  attr_accessor :new_record

  def initialize(page_url)
    page = YAML.load_file(PAGES_URL + page_url + PAGES_META).symbolize_keys

    self.layout = page[:layout]
    self.layout_full = page[:layout] + LAYOUTS_INDEX + PAGES_FORMAT
    self.head = page[:head].symbolize_keys

    self.page_full = PAGES_PATH + page_url + PAGES_INDEX + PAGES_FORMAT
    self.page = page_url

    self.content = File.read(PAGES_URL+ page_url + PAGES_INDEX + PAGES_FORMAT)
  end

  def self.all
    pages = Dir.glob PAGES_URL+"**"+PAGES_INDEX+PAGES_FORMAT
    pages.each do |page|
      page.slice! PAGES_URL
      page.slice! PAGES_INDEX
      page.slice! PAGES_FORMAT
    end
    pages.sort!
    pages.map{ |p| Page.new(p)}
  end

  def self.find(page_url)
    page = Page.new page_url
    page.id = page_url
    page
  end

  def page_breadcrumbs
    page_full.gsub('/',' › ')
  end

  def persisted?
    !(self.id.nil?)
  end

  def parse(page_url)

  end

end