require 'rails_helper'

RSpec.describe "Reservations", type: :request do
  context "GET /reservations" do
    let(:url) { "/reservations" }
    let!(:reservations) { create_list(:reservation, 5) }

    it "returns all reservations" do
      get url

      expect(body_json.size).to eq reservations.size
      expect(body_json.map { |reservation| reservation["id"] }).to match_array reservations.map(&:id)
    end

    it "returns success status" do
      get url

      expect(response).to have_http_status(:ok)
    end
  end

  context "POST /reservations" do
    let(:url) { "/reservations" }

    context "with valid params" do
      let(:reservation_params) { { reservation: attributes_for(:reservation) } }

      it "adds a new reservation" do
        expect do
          post url, params: reservation_params
        end.to change(Reservation, :count).by(1)
      end

      it "returns last added reservation" do
        post url, params: reservation_params

        expect(body_json["id"]).to eq Reservation.last.id
        expect(body_json["plate"]).to eq Reservation.last.plate
      end

      it "returns created status" do
        post url, params: reservation_params

        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid params" do
      let(:reservation_invalid_params) do
        { reservation: attributes_for(:reservation, plate: nil) }
      end

      it "does not add a new reservation" do
        expect do
          post url, params: reservation_invalid_params
        end.not_to change(Reservation, :count)
      end

      it "returns unprocessable entity status" do
        post url, params: reservation_invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  context "PATCH /reservations/:id" do
    let(:reservation) { create(:reservation) }
    let(:url) { "/reservations/#{reservation.id}" }

    context "with valid params" do
      let(:new_plate) { "BBB-1234" }
      let(:reservation_params) { { reservation: { plate: new_plate } } }

      it "updates reservation" do
        patch url, params: reservation_params

        expect(reservation.reload.plate).to eq new_plate
      end

      it "returns updated reservation" do
        patch url, params: reservation_params

        expect(body_json["id"]).to eq reservation.id
        expect(body_json["plate"]).to eq new_plate
      end

      it "returns success status" do
        patch url, params: reservation_params

        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid params" do
      let(:reservation_invalid_params) do
        { reservation: attributes_for(:reservation, plate: nil) }
      end

      it "does not update reservation" do
        old_plate = reservation.plate

        patch url, params: reservation_invalid_params

        expect(reservation.reload.plate).to eq old_plate
      end

      it "returns unprocessable entity status" do
        patch url, params: reservation_invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  context "DELETE /reservations/:id" do
    let!(:reservation) { create(:reservation) }
    let(:url) { "/reservations/#{reservation.id}" }

    it "removes reservation" do
      expect do
        delete url
      end.to change(Reservation, :count).by(-1)
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
