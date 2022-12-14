# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  before_action :configure_permitted_parameters

  # GET /resource/sign_up
  def new
    super
    unless cookies[:promoter]
      cookies[:promoter] = params[:promoter]
    end
  end

  # POST /resource
  def create
    cookies[:promoter]
    params[:user][:parent_id] = User.find_by(email: cookies[:promoter])&.id
    super
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  #

  protected

  def configure_permitted_parameters
    attr_update = [:user_id, :avatar, :avatar_cache, :remove_avatar, :phone, :username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :account_update, keys: attr_update
    attr_sign_up = [:parent_id, :children_members, :username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: attr_sign_up
  end

  def after_update_path_for(resource)
    new_user_registration_path
  end
  
end
