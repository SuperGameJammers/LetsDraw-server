defmodule Habanero.Subject do
  use Habanero.Web, :model

  schema "subjects" do
    has_many :drawings, Habanero.Drawing
    field :name, :string
    field :img_url, :string
    # Complexity can be "easy", "mid", "hard"
    field :complexity, :string

    timestamps
  end

  @required_fields ~w(name img_url complexity)
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
end
