class HomesController < ApplicationController

  before_action :authenticate_user!,except: [:about, :index ]


  def index
  end

  def about
  end

end
