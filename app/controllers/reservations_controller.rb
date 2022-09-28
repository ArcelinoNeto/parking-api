class ReservationsController < ApplicationController
    before_action :set_reservation, only: [:show, :update, :destroy]

    def index
        @reservations = Reservation.all

        render json: @reservations
    end

    def show
        render json: @reservation
    end
    
    def create
        @reservation = Reservation.new(reservation_params)

       if @reservation.save
        render json: @reservation, status: :created, location: @reservation
       elsif 
        render json: @reservation.errors, status: :unprocessable_entity
       end
    end
    
    def update
        if @reservation.update(reservation_params)
            render json: @reservation
        else
            render json: @reservation.errors, status: :unprocessable_entity
        end
    end
    
    def destroy
        @reservation.destroy
    end

    private
    
    def set_reservation
        @reservation = Reservation.find(params[:id])
    end

    def reservation_params
        return {} unless params.has_key?(:reservation)
        params.require(:reservation).permit(:plate, :entry, :exit, :status)
    end
end
