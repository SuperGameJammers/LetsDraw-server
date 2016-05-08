defmodule Habanero.Score do
  use Habanero.Web, :model

  schema "scores" do
    belongs_to :drawing, Habanero.Drawing
    field :rate, :integer
    field :img_url, :string

    timestamps
  end

  @required_fields ~w(rate img_url drawing_id)
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
