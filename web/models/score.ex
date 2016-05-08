defmodule Habanero.Score do
  use Habanero.Web, :model

  alias Habanero.{Drawing, Repo, Score}

  schema "scores" do
    belongs_to :drawing, Drawing
    field :rate, :integer
    field :img_url, :string

    timestamps
  end

  @required_fields ~w(rate drawing_id)
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

  def by_drawing(drawing_id) do
    query = from(score in Score,
        where: score.drawing_id == ^drawing_id)
    
    Repo.all(query)
  end
end
