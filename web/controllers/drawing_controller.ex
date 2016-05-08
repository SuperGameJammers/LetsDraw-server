defmodule Habanero.DrawingController do
  use Habanero.Web, :controller
  require IEx

  alias Habanero.Drawing

  plug :scrub_params, "drawing" when action in [:create, :update]

  def index(conn, _params) do
    drawings = Repo.all(Drawing)
    render(conn, "index.json", drawings: drawings)
  end

  def by_subject(conn, %{"subject_id" => subject_id}) do
    drawings = Drawing.by_subject(subject_id)
    render(conn, "index.json", drawings: drawings)
  end

  def create(conn, %{"drawing" => drawing_params}) do
    img = parse_img(drawing_params)
    drawing_params = Map.put(drawing_params, "img_url", img)
    changeset = Drawing.changeset(%Drawing{}, drawing_params)
    case Repo.insert(changeset) do
      {:ok, drawing} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", drawing_path(conn, :show, drawing))
        |> render("show.json", drawing: drawing)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Habanero.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def get_all(conn) do
  	query = from d in Drawings,
  			select: d
  	json(conn, Repo.all(query))
  end
  defp parse_img(drawing_params) do
    img = drawing_params["img"]
       |> Base.decode64!
    File.write("./priv/tmp/#{drawing_params["name"]}.png", img)

    %Plug.Upload{content_type: "image/png", 
                 filename: "#{drawing_params["name"]}.png", 
                 path: "./priv/tmp/#{drawing_params["name"]}.png"}
  end

  def show(conn, %{"id" => id}) do
    drawing = Repo.get!(Drawing, id)
    render(conn, "show.json", drawing: drawing)
  end

  def update(conn, %{"id" => id, "drawing" => drawing_params}) do
    drawing = Repo.get!(Drawing, id)
    changeset = Drawing.changeset(drawing, drawing_params)

    case Repo.update(changeset) do
      {:ok, drawing} ->
        render(conn, "show.json", drawing: drawing)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Habanero.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    drawing = Repo.get!(Drawing, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(drawing)

    send_resp(conn, :no_content, "")
  end
end
