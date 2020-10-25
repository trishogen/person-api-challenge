class PersonSerializer

  def initialize(person)
    @person = person
  end

  def to_serialized_json
    # exclude the timestamps on the Person from the json returned by the API
    options = {
      except: [:updated_at, :created_at],
    }

    @person.to_json(options)
  end

end
