defmodule Habanero.ScoreTest do
  use Habanero.ModelCase

  alias Habanero.Score

  @valid_attrs %{img_url: "some content", rate: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Score.changeset(%Score{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Score.changeset(%Score{}, @invalid_attrs)
    refute changeset.valid?
  end
end
