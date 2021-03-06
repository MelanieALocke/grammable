class GramsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def show
    @gram = find_gram
    return blank_gram if @gram.blank?
  end

  def edit
    @gram = find_gram
    return blank_gram if @gram.blank?
    return blank_gram(:forbidden) if @gram.user != current_user
  end

  def update
    @gram = find_gram
    return blank_gram if @gram.blank?

    return blank_gram(:forbidden) if @gram.user != current_user

    @gram.update_attributes(gram_params)

    if @gram.valid?
      redirect_to root_path
    else
      return render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @gram = find_gram
    return blank_gram if @gram.blank?

    return blank_gram(:forbidden) if @gram.user != current_user

    @gram.destroy
    redirect_to root_path
  end

  def new
    @gram = Gram.new
  end

  def index
    @grams = Gram.all
  end

  def create
    @gram = current_user.grams.create(gram_params)
    if @gram.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end


  private

  def gram_params
    params.require(:gram).permit(:picture, :message)
  end

  def find_gram
    Gram.find_by_id(params[:id])
  end

end
