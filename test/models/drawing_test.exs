defmodule Habanero.DrawingTest do
  use Habanero.ModelCase

  alias Habanero.Drawing

  @valid_attrs %{img_url: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Drawing.changeset(%Drawing{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Drawing.changeset(%Drawing{}, @invalid_attrs)
    refute changeset.valid?
  end
end
