class Api::ReviewsController < ApplicationController
  def show
    @review = Review.find(params[:id])
  end

  def create
    review = Review.new(review_params)
    review.user_id = current_user.id
    if review.save
      @serie = review.serie
      render '/api/series/show'
    else
      render json: review, status: :unprocessable_entity
    end
  end

  def update
    review = Review.find(params[:id])
    if review.save
      @serie = review.serie
      render '/api/series/show'
    else
      render json: review, status: :unprocessable_entity
    end
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    @serie = review.serie
    render 'api/series/show'
  end

  private

  def review_params
    params.require(:review).permit(:serie_id, :rating, :body)
  end
end