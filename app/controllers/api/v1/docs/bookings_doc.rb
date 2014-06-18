class Api::V1::Docs::BookingsDoc <  ActionController::Base

  def self.create
    <<-EOS
      {
        status: 200
        message: "Successfully"
        booking: {
          id: 4
          user: {
            id: 11
            email: "hoangtestapi10@aa.vn"
            is_online: true
            auth_token: "nd6AmVaqf1Y_xZcw8aLH"
          }-
          driver: {
            id: 2
            name: "Internal Tactics Officer"
            gender: 0
            birthday: "1990-01-01T00:00:00.000Z"
            phone_number: "0173947464"
            taxi_number: "76529"
            company: "King-Schulist"
            seater_number: 4
            latitude: 10.7915425
            longitude: 106.6971481
            address: "50 Pasture, Quận 1, Ho Chi Minh City, Vietnam"
          }-
          status: 0
          latitude: 10.7915425
          longitude: 106.6971481
          address: "55 Nguyễn Văn Giai, Đa Kao, Quận 1, Ho Chi Minh City, Vietnam"
        }        
      }
    EOS
  end

  def self.get_booking
    <<-EOS
      {
        status: 200
        message: "Successfully"
        booking: {
          id: 5
          user: {
            id: 11
            email: "hoangtestapi10@aa.vn"
            is_online: true
            auth_token: "nd6AmVaqf1Y_xZcw8aLH"
          }-
          driver: {
            id: 2
            name: "Internal Tactics Officer"
            gender: 0
            birthday: "1990-01-01T00:00:00.000Z"
            phone_number: "0173947464"
            taxi_number: "76529"
            company: "King-Schulist"
            seater_number: 4
            latitude: 10.7915425
            longitude: 106.6971481
            address: "55 Nguyễn Văn Giai, Đa Kao, Quận 1, Ho Chi Minh City, Vietnam"
          }-
          status: 0
          latitude: 10.7915425
          longitude: 106.6971481
          address: "55 Nguyễn Văn Giai, Đa Kao, Quận 1, Ho Chi Minh City, Vietnam"
        }
      }
    EOS
  end

end
