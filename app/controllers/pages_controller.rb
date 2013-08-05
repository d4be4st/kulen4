class PagesController < ApplicationController

  def pages
    @page = Page.new(params[:url])
    render @page.page_full, layout: @page.layout_full
  end

end