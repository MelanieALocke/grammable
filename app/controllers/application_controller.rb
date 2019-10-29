class ApplicationController < ActionController::Base

  def blank_gram(status=:not_found)
    render plain: "#{status.to_s.titleize} :(", status: status
  end

end
