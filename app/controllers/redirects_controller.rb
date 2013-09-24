class RedirectsController < ApplicationController

  def old_site
    new_id = new_id(params[:id])
    if new_id
      redirect_to post_path(:id => new_id), :status => :moved_permanently
    else
      render :text => "Not Found!", :status => "404"
    end
  end


  private

  # maps id's from the old modernwanderlust.com to new ones
  def new_id(old_id)
    new_id = {
      "21" => "2",
      "22" => "1"
    }[old_id]
  end


end
