puts "==================== Create sample data for drivers ======"
arr_address = [
                I18n.t('adreess.a'),
                I18n.t('adreess.b'),
                I18n.t('adreess.c'),
                I18n.t('adreess.d'),
                I18n.t('adreess.e'),
                I18n.t('adreess.f'),
                I18n.t('adreess.g'),
                I18n.t('adreess.h'),
                I18n.t('adreess.j'),
                I18n.t('adreess.k'),
                I18n.t('adreess.m'),
                I18n.t('adreess.n'),
                I18n.t('adreess.o'),
                I18n.t('adreess.p')
          ]
drivers = Array.new
num = 4
arr_address.each do |address|
  if num == 7
    num = 4
  else
    num = 7
  end
  driver = Driver.find_by_address(address)
  unless driver
    drivers << {
                  :name => Faker::Name.title,
                  :gender => rand(0..1),
                  :birthday => "1990-1-1",
                  :phone_number => Faker::Number.number(10),
                  :taxi_number => Faker::Number.number(5),
                  :company => Faker::Company.name,
                  :sit_number => num,
                  :address => address,
                  :status => Driver::STATUS[:free]
                }
  end
end
Driver.create(drivers)
puts "==================== Finished =============="