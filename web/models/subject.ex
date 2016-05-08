defmodule Habanero.Subject do
  use Habanero.Web, :model
  use Arc.Ecto.Model

  schema "subjects" do
    has_many :drawings, Habanero.Drawing
    field :name, :string
    field :img_url, Habanero.SubjectImage.Type
    # Complexity can be "easy", "mid", "hard"
    field :complexity, :string
    field :characteristics, {:array, :string}

    timestamps
  end

  @required_fields ~w(name complexity characteristics)
  @optional_fields ~w()

  @required_file_fields ~w(img_url)
  @optional_file_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> cast_attachments(params, @required_file_fields, @optional_file_fields)
  end
end
