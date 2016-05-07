defmodule Habanero.SubjectControllerTest do
  use Habanero.ConnCase

  alias Habanero.Subject
  @valid_attrs %{img_url: "some content", name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, subject_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    subject = Repo.insert! %Subject{}
    conn = get conn, subject_path(conn, :show, subject)
    assert json_response(conn, 200)["data"] == %{"id" => subject.id,
      "name" => subject.name,
      "img_url" => subject.img_url}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, subject_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, subject_path(conn, :create), subject: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Subject, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, subject_path(conn, :create), subject: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    subject = Repo.insert! %Subject{}
    conn = put conn, subject_path(conn, :update, subject), subject: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Subject, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    subject = Repo.insert! %Subject{}
    conn = put conn, subject_path(conn, :update, subject), subject: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    subject = Repo.insert! %Subject{}
    conn = delete conn, subject_path(conn, :delete, subject)
    assert response(conn, 204)
    refute Repo.get(Subject, subject.id)
  end
end
