class KittensController < ApplicationController
  def index
    @kittens = Kitten.all

    respond_to do |format|
      format.html
      format.json { render :json => @kittens }
    end
  end

  def show
    @kitten = Kitten.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => @kitten }
    end
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)

    if @kitten.save
      flash.notice = 'New kitten created'
      redirect_to @kitten
    else
      flash.now.notice = 'You can\'t have a kitten without all this info'
      render :new
    end
  end

  def edit
    @kitten = Kitten.find(params[:id])
  end

  def update
    if @kitten.update(kitten_params)
      flash.notice = 'Kitten has been updated'
      redirect_to @kitten
    else
      flash.now.notice = 'You can\'t have a kitten without all this info'
      render :edit
    end
  end

  def destroy
    @kitten = Kitten.find(params[:id])

    @kitten.destroy
    flash.notice = 'You have destroyed that kitten. You monster.'
    redirect_to kittens_path
  end

  private

  def kitten_params
    params.require(:kitten).permit(:name, :age, :cuteness, :softness)
  end
end
