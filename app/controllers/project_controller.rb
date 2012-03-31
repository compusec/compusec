class ProjectController < ApplicationController
  def restart
    system "rake db:migrate VERSION=0"
    system "rake db:migrate"
    redirect_to(:root)
  end
end
