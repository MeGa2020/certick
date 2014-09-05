class CertifiedsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_certified, only: [:show, :edit, :update, :destroy]

  respond_to :html

  # GET /certifieds
  # GET /certifieds.json
  def index
    @certifieds = Certified.where(user: self.current_user)
  end

  # GET /certifieds/1
  # GET /certifieds/1.json
  def show
  end

  # GET /certifieds/1/edit
  def edit
  end

  # GET /certifieds/new
  def new
    @certified = Certified.new(user: current_user)
    @events = Eventick::API.new.events(current_user.token).map { |p| [ p['title'], p['id'] ] }

    if @events.empty?
      flash.now[:notice] = "No events available to add abackground. All your events already have background set."
      redirect_to certifieds_url
    end
  end

  # POST /certifieds
  # POST /certifieds.json
  def create
    @certified = Certified.new(certified_params)
    @certified.events = events
    @certified.attendees = attendees
    @certified.slug = generate_token
    @certified.user = self.current_user

    flash[:notice] = "Certificado criado com sucesso." if @certified.save

    respond_with(@certified) do |format|
      format.html { redirect_to @certified }
    end
  end

  # PATCH/PUT /certifieds/1
  # PATCH/PUT /certifieds/1.json
  def update
    respond_to do |format|
      @certified.background_url = params[:background_url]

      if @certified.update(certified_params)
        format.html { redirect_to @certified, notice: 'Certified was successfully updated.' }
        format.json { head :no_content }
      else
        format.html {
          render action: 'edit', alert: @certified.errors.to_a
        }
        format.json { render json: @certified.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /certifieds/1
  # DELETE /certifieds/1.json
  def destroy
    @certified.destroy
    respond_to do |format|
      format.html { redirect_to certifieds_url }
      format.json { head :no_content }
    end
  end

  private
  def events
    event = eventick.event(current_user.token, params[:certified][:event_id]).first
    { event_title: event['title'], event_start_at: event['start_at'], event_venue: event['venue'], event_slug: event['slug'] }
  end

  def attendees
    hash = { }
    attendees = eventick.attendees(current_user.token, params[:certified][:event_id])
    attendees.each { |a| hash[a['email']] = a['name'] }
    hash
  end

  def generate_token
    token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Certified.where(slug: random_token).exists?
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_certified
    @certified = Certified.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def certified_params
    params.require(:certified).permit( :background_url, :event_id, :name_color)
  end
end
