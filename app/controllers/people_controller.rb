class PeopleController < ApplicationController
  # sets the person instance variable before the specified actions
  before_action :set_person, only: [:show, :update, :destroy]

  def index
    # GET all the people
    people = Person.all

    # send the list of people objects to the serializer to get a json list
    render json: PersonSerializer.new(people).to_serialized_json, status: :ok
  end

  def show
    # GET 1 person
    if @person # uses the person set using the before_action hook
      # send the person object to the serializer to make a json object
      render json: PersonSerializer.new(@person).to_serialized_json, status: :ok
    else
      render json: { error: "Person not found" }, status: :not_found
    end

  end

  def create
    # POST to people
    person = Person.new(person_params) # initialize new person with strong params

    if person.save
      # if the person was able to save successfully return json
      render json: PersonSerializer.new(person).to_serialized_json, status: :created
    else
      # if the person was not able to be saved show the message from the first failed validation
      render json: { error: person.errors.full_messages[0] }, status: :bad_request
    end
  end

  def update
    # PUT to a person
    if @person.update(person_params) # uses the person set using the before_action hook
      # if the updates to the person were able to save successfully return json
      render json: PersonSerializer.new(@person).to_serialized_json, status: :ok
    else
      # if the update was unable to save show the message from the first failed validation
      render json: { error: @person.errors.full_messages[0] }, status: :bad_request
    end
  end


  def destroy
    # DELETE a person
    @person.destroy

    render json: {}, status: :no_content
  end

  private

  def person_params
    # strong params to enforce permissable parameters
    params.require(:person).permit(:first_name, :middle_name, :last_name,
      :email, :age)
  end

  def set_person
    # finds a given person by their ID
    @person = Person.find(params[:id])
  end

end
