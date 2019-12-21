class Clients::BaseController < ApplicationController
    before_action :authenticate_client!
end
