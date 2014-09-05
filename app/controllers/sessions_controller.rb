class SessionsController < ApplicationController

	def new
		@user = User.new
	end

	def create
		token = authenticate(params[:email], params[:password])

		if token
			self.current_user = User.find_or_create_by(token: token)
			redirect_to certifieds_path, notice: 'Bem vindo!'
		else
			flash.now[:alert] = 'Usuário ou senha inválida.'
			render :new
		end
	end

	private
	def authenticate(email, password)
		Eventick::API.new.token(email, password)
	end
end
