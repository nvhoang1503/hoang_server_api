class Api::V1::BookingsController < Api::V1::BaseApiController
  skip_before_filter :api_authenticate_user!
  
  api :POST, 'v1/bookings', 'Booking a nearest taxi (If client do not input current location, system will get address of current user)'
  param :auth_token, String, :desc => "auth_token of user", :required => true
  param :sit_number, :number, :desc => "Sit number of taxi", :required => true
  param :address, String, :desc => "Current location of user", :required => false
  param :latitude, :number, :desc => "Latitude of current location", :required => false
  param :longitude, :number, :desc => "Longitude of current location", :required => false

  def create
    required :auth_token, :sit_number
    latitude    = "%.10f" % params[:latitude] if params[:latitude] && params[:latitude].length > 0
    longitude   = "%.10f" % params[:longitude] if params[:longitude] && params[:longitude].length > 0
    address     = params[:address] if params[:address] && params[:address].length > 0
    sit_number  = params[:sit_number]
    if params[:latitude] && params[:latitude].length > 0 && params[:longitude] && params[:longitude].length > 0
      driver = Driver.near([latitude,longitude],20).where("status = ? and sit_number = ?", Driver::STATUS[:free], sit_number).first
    elsif params[:address] && params[:address].length > 0
      driver = Driver.near(address,20).where("status = ? and sit_number = ?", Driver::STATUS[:free], sit_number).first
    else
      driver = Driver.near(current_user.address,20).where("status = ? and sit_number = ?", Driver::STATUS[:free], sit_number).first
    end
    if driver
      booking = Booking.create(
                      :user_id    => current_user.id,
                      :driver_id  => driver.id,
                      :status     => Booking::STATUS[:pending],
                      :latitude   => latitude,
                      :longitude  => longitude,
                      :address    => address
                    )
      render json: {
                    :status   => 200,
                    :message  =>  "Successfully",
                    :booking  => booking
                  }
    else
      render json: {
                    :status   => 400,
                    :message  => "Unsuccess",
                    :error    => "Taxi is fulling"
                  }
    end
  end

  api :PUT, 'v1/bookings/confirm', 'Booking confirm'
  param :auth_token, String, :desc => "auth_token of user", :required => true
  param :booking_id, :number, :desc => "Booking ID", :required => true
  param :confirm_status, :number, :desc => "accept: 1, reject: 2", :required => true
  def confirm
    required :auth_token, :booking_id
    booking = Booking.find_by_id(params[:booking_id])
    if booking
      if current_user && current_user.id == booking.user_id
        if params[:confirm_status].to_i == Booking::STATUS[:accepted]
          booking.update_attribute("status", Booking::STATUS[:accepted])
          diver = Driver.find(booking.driver_id)
          diver.update_attribute("status",Driver::STATUS[:busy])
          render json: {
                      :status   => 200,
                      :message  =>  "Successfully",
                      :status   => booking.status
                    }
        else
          booking.update_attribute("status", Booking::STATUS[:rejected])
          render json: {
                      :status   => 200,
                      :message  =>  "Successfully",
                      :status   => booking.status
                    }
        end
      else
        render json: {
                      :status   => 400,
                      :message  =>  "Unsuccessfully",
                      :error    => "Permission denied"
                    }
      end
    else
      render json: {
                      :status   => 400,
                      :message  =>  "Unsuccessfully",
                      :error    => "Booking is not existing"
                    }
    end
  end
end