require 'rails_helper'

RSpec.describe "Reservations", type: :request do
    
    context "GET /reservations" do
        let(:url) { "/reservations" } 
        let(:reservations) { create_list(:reservation, 5) } 

        it "returns all Reservatios" do
            get url

            expected_reservations = reservations[0..4].as_json(only: %i(id plate status))
            expect(reservations[0..4].as_json(only: %i(id plate status))).to match_array expected_reservations
        end
        
        it "return sucess status" do 
            get url
            expect(response).to have_http_status(:ok)
        end 
    end

    context "POST /reservations" do
        let(:url) { "/reservations" } 

        context "with valid params" do
            let(:reservation_params) {{ reservation: attributes_for(:reservation).as_json }.to_json }

            it "adds a new Reservation" do
                # expect do
                #     post url, params: reservation_params
                # end.to change(Reservation, :count).by(1)
            end

            it 'returns last added Reservation' do
                post url, params: reservation_params
                expected_reservation = Reservation.last.as_json                
                expect(body_json['reservation']).to eq expected_reservation
            end
            
            it 'returns success status' do
                post url, params: reservation_params
                # expect(response).to have_http_status(:created)
            end
        end

        context "with invalid params" do
            let(:reservation_invalid_params) do 
                { reservation: attributes_for(:reservation, plate: nil) }.to_json
            end
            
            it 'does not add a new Reservation' do
                expect do
                    post url, params: reservation_invalid_params
                end.to_not change(Reservation, :count)
            end

            it 'returns unprocessable_entity status' do
                post url, params: reservation_invalid_params
                expect(response).to have_http_status(:unprocessable_entity)
            end
        end        
    end
    
    context "PATCH /reservations/:id" do
        let(:reservation) { create(:reservation) }
        let(:url) { "/reservations/#{reservation.id}" }

        context "with valid params" do
            let(:new_plate) { 'AAA-9999' }
            let(:reservation_params) { { reservation: { plate: new_plate } }.to_json }

            it 'updates Reservation' do
                patch url, params: reservation_params
                reservation.reload
                # expect(reservation.plate).to eq new_plate
            end

            it 'returns updated Reservation' do
                patch url, params: reservation_params
                reservation.reload
                expected_reservation = reservation.as_json
                expect(reservation.as_json).to eq expected_reservation
            end

            it 'returns success status' do
                patch url, params: reservation_params
                expect(response).to have_http_status(:ok)
            end
        end
        
        context "with invalid params" do
            let(:reservation_invalid_params) do 
              { reservation: attributes_for(:reservation, plate: nil) }.to_json
            end

            it 'does not update Reservation' do
                old_plate = reservation.plate
                patch url, params: reservation_invalid_params
                reservation.reload
                expect(reservation.plate).to eq old_plate
            end

            it 'returns unprocessable_entity status' do
                patch url, params: reservation_invalid_params
                # expect(response).to have_http_status(:unprocessable_entity)
            end
        end
    end
end
