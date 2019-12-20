##
# A class representing a controller which handles HTTP requests to the website root.
class HomeController < ApplicationController
  def index
    @sections = Section.where(draft: false).order(id: :asc)
  end
end
