defmodule Habanero.Drawing do
  use Habanero.Web, :model
  alias Habanero.{Subject, Drawing, Repo}

  schema "drawings" do
    belongs_to :subject, Subject
    field :img_url, :string
    field :name, :string

    timestamps
  end

  @required_fields ~w(img_url name subject_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def by_subject(subject_id) do
    query = from(drawing in Drawing,
        where: drawing.subject_id == ^subject_id)
    
    Repo.all(query)
  end
end
