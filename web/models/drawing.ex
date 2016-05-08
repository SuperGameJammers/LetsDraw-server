defmodule Habanero.Drawing do
  use Habanero.Web, :model
  alias Habanero.{Subject, Drawing, Repo, Score}
  use Arc.Ecto.Model

  schema "drawings" do
    belongs_to :subject, Subject
    has_many :scores, Score

    field :img_url, Habanero.DrawingImage.Type
    field :name, :string
    field :order, :integer

    timestamps
  end

  @required_fields ~w(name subject_id order)
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

  def by_subject(subject_id) do
    query = from(drawing in Drawing,
        where: drawing.subject_id == ^subject_id,
        order_by: [asc: drawing.order])
    
    Repo.all(query)
  end
end
