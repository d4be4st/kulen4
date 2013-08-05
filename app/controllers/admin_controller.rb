class AdminController < ApplicationController

  http_basic_authenticate_with :name => "admin", :password => "pass123"

  layout 'admin/layout'
end
