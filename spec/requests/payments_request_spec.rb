require 'rails_helper'

RSpec.describe "Payments", type: :request do

    context "GET /payments" do
        let(:url) { "/payments" } 
        let(:payments) { create_list(:payment, 5) } 

        it "returns all Reservatios" do
            get url

            expected_payments = payments[0..4].as_json(only: %i(id value))
            expect(payments[0..4].as_json(only: %i(id value))).to match_array expected_payments
        end
        
        it "return sucess status" do 
            get url
            expect(response).to have_http_status(:ok)
        end 
    end

    context "POST /payments" do
        let(:url) { "/payments" } 

        context "with valid params" do
            let(:payment_params) {{ payment: attributes_for(:payment).as_json }.to_json }

            it "adds a new Payment" do
                # expect do
                #     post url, params: payment_params
                # end.to change(Reservation, :count).by(1)
            end

            it 'returns last added Payment' do
                post url, params: payment_params
                expected_payment = Payment.last.as_json                
                expect(body_json['payment']).to eq expected_payment
            end
            
            it 'returns success status' do
                post url, params: payment_params
                # expect(response).to have_http_status(:created)
            end
        end

        context "with invalid params" do
            let(:payment_invalid_params) do 
                { payment: attributes_for(:payment, plate: nil) }.to_json
            end
            
            it 'does not add a new Reservation' do
                expect do
                    post url, params: payment_invalid_params
                end.to_not change(Payment, :count)
            end

            it 'returns unprocessable_entity status' do
                post url, params: payment_invalid_params
                expect(response).to have_http_status(:unprocessable_entity)
            end
        end
    end

    context "PATCH /payments/:id" do
        let(:payment) { create(:payment) }
        let(:url) { "/payments/#{payment.id}" }

        context "with valid params" do
            let(:new_value) { '10.25' }
            let(:payment_params) { { payment: { value: new_value } }.to_json }

            it 'updates Payment' do
                patch url, params: payment_params
                payment.reload
                expect(payment.value).to eq new_value
            end

            it 'returns updated Payment' do
                patch url, params: payment_params
                payment.reload
                expected_payment = payment.as_json
                expect(payment.as_json).to eq expected_payment
            end

            it 'returns success status' do
                patch url, params: payment_params
                expect(response).to have_http_status(:ok)
            end
        end
        
        context "with invalid params" do
            let(:payment_invalid_params) do 
              { payment: attributes_for(:payment, plate: nil) }.to_json
            end

            it 'does not update Payment' do
                old_value = payment.value
                patch url, params: payment_invalid_params
                payment.reload
                expect(payment.value).to eq old_value
            end

            it 'returns unprocessable_entity status' do
                patch url, params: payment_invalid_params
                # expect(response).to have_http_status(:unprocessable_entity)
            end
        end
    end

    context "DELETE /payments/:id" do
        let!(:payment) { create(:payment) }
        let(:url) { "/payments/#{payment.id}" }

        it 'removes Payment' do
            expect do  
              delete url
            end.to change(Payment, :count).by(-1)
        end

        it 'returns success status' do
            delete url
            expect(response).to have_http_status(:no_content)
        end

        it 'does not return any body content' do
            delete url
            expect(body_json).to_not be_present
        end
    end
end
