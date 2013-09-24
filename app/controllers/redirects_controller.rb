class RedirectsController < ApplicationController

  def old_site
    new_id = new_id(params[:id])
    if new_id
      redirect_to post_path(:id => new_id), :status => :moved_permanently
    else
      render :text => "Not Found!", :status => "404"
    end
  end


  # private

  # maps id's from the old modernwanderlust.com to new ones
  # Yep, it's that ugly.
  def new_id(old_id)
    if old_id == "22"
      return "1"
    elsif old_id == "21"
      return "2"
    elsif old_id <= "88"
      return (old_id.to_i - 20).to_s
    elsif old_id == "89"
      return "70"
    elsif old_id == "90"
      return "69"
    elsif old_id <= "93"
      return (old_id.to_i - 20).to_s
    else 
      return (old_id.to_i - 21).to_s
    end
  end


end
