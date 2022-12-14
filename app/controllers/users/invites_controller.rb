class Users::InvitesController < ApplicationController
    require "rqrcode"
    before_action :invite_link
    before_action :generate_qrcode
  
    def index; end
  
    private
  
    def invite_link
      if current_user
        @url = "#{request.base_url}/users/sign_up?promoter=#{current_user.email}"
      else
        @url = "#{request.base_url}/users/sign_up"
      end
    end
  
    def generate_qrcode
      qrcode = RQRCode::QRCode.new("#{invite_link}")
      @svg = qrcode.as_svg(
        color: "000",
        shape_rendering: "crispEdges",
        module_size: 5,
        standalone: true,
        use_path: true
      )
    end
  end
