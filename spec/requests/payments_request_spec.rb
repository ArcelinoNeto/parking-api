require 'rails_helper'

RSpec.describe "Payments", type: :request do
  context "GET /payments" do
    let(:url) { "/payments" }
    let!(:payments) { create_list(:payment, 5) }

    it "returns all payments" do
      get url

      expect(body_json.size).to eq payments.size
      expect(body_json.map { |payment| payment["id"] }).to match_array payments.map(&:id)
    end

    it "returns success status" do
      get url

      expect(response).to have_http_status(:ok)
    end
  end

  context "POST /payments" do
    let(:url) { "/payments" }
    let(:reservation) { create(:reservation) }

    context "with valid params" do
      let(:payment_params) do
        { payment: attributes_for(:payment).merge(reservation_id: reservation.id) }
      end

      it "adds a new payment" do
        expect do
          post url, params: payment_params
        end.to change(Payment, :count).by(1)
      end

      it "returns last added payment" do
        post url, params: payment_params

        expect(body_json["id"]).to eq Payment.last.id
        expect(body_json["reservation_id"]).to eq reservation.id
        expect(BigDecimal(body_json["value"].to_s)).to eq Payment.last.value
      end

      it "returns created status" do
        post url, params: payment_params

        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid params" do
      let(:payment_invalid_params) do
        { payment: attributes_for(:payment, value: nil).merge(reservation_id: reservation.id) }
      end

      it "does not add a new payment" do
        expect do
          post url, params: payment_invalid_params
        end.not_to change(Payment, :count)
      end

      it "returns unprocessable entity status" do
        post url, params: payment_invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  context "PATCH /payments/:id" do
    let(:payment) { create(:payment) }
    let(:url) { "/payments/#{payment.id}" }

    context "with valid params" do
      let(:new_value) { BigDecimal("15.75") }
      let(:payment_params) { { payment: { value: new_value } } }

      it "updates payment" do
        patch url, params: payment_params

        expect(payment.reload.value).to eq new_value
      end

      it "returns updated payment" do
        patch url, params: payment_params

        expect(body_json["id"]).to eq payment.id
        expect(BigDecimal(body_json["value"].to_s)).to eq new_value
      end

      it "returns success status" do
        patch url, params: payment_params

        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid params" do
      let(:payment_invalid_params) do
        { payment: attributes_for(:payment, value: nil) }
      end

      it "does not update payment" do
        old_value = payment.value

        patch url, params: payment_invalid_params

        expect(payment.reload.value).to eq old_value
      end

      it "returns unprocessable entity status" do
        patch url, params: payment_invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  context "DELETE /payments/:id" do
    let!(:payment) { create(:payment) }
    let(:url) { "/payments/#{payment.id}" }

    it "removes payment" do
      expect do
        delete url
      end.to change(Payment, :count).by(-1)
    end

    it "returns no content status" do
      delete url

      expect(response).to have_http_status(:no_content)
    end

    it "does not return any body content" do
      delete url

      expect(response.body).to be_blank
    end
  end
end
