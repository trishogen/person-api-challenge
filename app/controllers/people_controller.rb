class PeopleController < ApplicationController
  # sets the person instance variable before the specified actions
  before_action :set_person, only: [:show]

  def show
    # send the person object to the serializer to make a json object
    if @person
      render json: PersonSerializer.new(@person).to_serialized_json, status: :ok
    else
      render json: { error: "Person not found" }, status: :not_found
    end

  end

  private

  def set_person
    # finds a given person by their ID
    @person = Person.find_by(id: params[:id])
  end

end
