class ListingsController < ApplicationController
  before_action :set_listing, only: %i[ show edit update destroy ]

  # GET /listings or /listings.json
  def index
    @listings = Listing.all
  end

  # GET /listings/1 or /listings/1.json
  def show
  end

  # GET /listings/new
  def new
    authorize Listing
    @listing = Listing.new
  end

  # GET /listings/1/edit
  def edit
    authorize @listing
  end

  # POST /listings or /listings.json
  def create
    authorize @listing
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user.id
    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: "Listing was successfully created." }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1 or /listings/1.json
  def update
    authorize @listing
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: "Listing was successfully updated." }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1 or /listings/1.json
  def destroy
    authorize @listing
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: "Listing was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_listing
    @listing = Listing.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def listing_params
    params.require(:listing).permit(:name, :price, :description, :ingredients, :user_id)
  end
end
