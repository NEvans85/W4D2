class CatRentalRequestsController < ApplicationController
  def new
    @cat_rental_request = CatRentalRequest.new
    render :new
  end

  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)

    if @cat_rental_request.save
      redirect_to cat_url(@cat_rental_request.cat)
    else
      render json: @cat_rental_request.errors.full_messages, status: :unprocessable_entity
    end
  end

  def edit

  end

  def update

  end

  def index

  end

  def show
    @cat_rental_request = CatRentalRequest.find(params[:id])

    if @cat_rental_request
      redirect_to cat_url(@cat_rental_request.cat)
    else
      render json: @cat_rental_request.errors.full_messages, status: 404
    end

  end

  def destroy

  end

  private

  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date, :status)
  end
end
