class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  private

  def authenticate_banking_facility
    @current_banking_facility = authenticate_with_http_token do |token, _|
      hashed = Digest::SHA256.hexdigest(token)
      BankingFacility.find_by(api_key_digest: hashed)
    end

    unless @current_banking_facility
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end
end
