class UserAnimalsController < ApplicationController
  def index
    user_animals = UserAnimal.where(user: current_user, status: :active)
    render json: user_animals
  end

  def create
    UserAnimal.transaction do
      current_user.user_animals.active.update_all(status: :inactive)

      user_animal = UserAnimal.new(user_animal_params)
      user_animal.user = current_user
      user_animal.status = :active

      if user_animal.save
        render json: user_animal, status: :created
      else
        Rails.logger.error("UserAnimal save failed: #{user_animal.errors.full_messages}")
        render json: user_animal.errors, status: :unprocessable_entity
        raise ActiveRecord::Rollback
      end
    end
  end

  private

  def user_animal_params
    params.require(:user_animal).permit(:animal_id)
  end
end
