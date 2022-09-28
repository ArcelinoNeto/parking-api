namespace :dev do
  desc "Configurando ambiente de desenvolvimenteo e teste"
  task setup: :environment do

    puts "Zerando a base..."
    
    %x(rails db:drop db:create db:migrate)
    
    puts "Base zerada com sucesso!"
    puts " "
    
    puts "Cadastrando Reservas..."

    10.times do |i|
      Reservation.create!(
        plate: Faker::Vehicle.license_plate ,
        entry: Faker::Time.between_dates(from: Date.today, to: Date.today, period: :morning),
        exit: Faker::Time.between_dates(from: Date.today, to: Date.today, period: :afternoon),
        status: [0 , 1].sample
      )
    end

    puts "Reservas cadastrados com sucesso!"
    puts ""

  end

end
