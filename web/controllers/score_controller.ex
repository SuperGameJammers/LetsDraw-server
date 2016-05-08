defmodule Habanero.ScoreController do
  use Habanero.Web, :controller

  alias Habanero.{Score, CallPython, Drawing, DrawingImage}

  plug :scrub_params, "score" when action in [:create, :update]

  def index(conn, _params) do
    scores = Repo.all(Score)
    render(conn, "index.json", scores: scores)
  end

  def by_drawing(conn, %{"drawing_id" => drawing_id}) do
    scores = Score.by_drawing(drawing_id)
    render(conn, "index.json", scores: scores)
  end

  def create(conn, %{"score" => score_params}) do
    drawing = Repo.get!(Drawing, score_params["drawing_id"])
    drawing_img = DrawingImage.url({drawing.img_url, drawing})
    img = parse_img(score_params)
    rate = CallPython.smart_script(drawing_img, img)
         |> round
    
    score_params = Map.put(score_params, "rate", rate)
    changeset = Score.changeset(%Score{}, score_params)

    case Repo.insert(changeset) do
      {:ok, score} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", score_path(conn, :show, score))
        |> render("show.json", score: score)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Habanero.ChangesetView, "error.json", changeset: changeset)
    end
  end

  defp parse_img(score_params) do
    score_params["img"]
    |> Base.decode64!
  end

  def show(conn, %{"id" => id}) do
    score = Repo.get!(Score, id)
    render(conn, "show.json", score: score)
  end

  def update(conn, %{"id" => id, "score" => score_params}) do
    score = Repo.get!(Score, id)
    changeset = Score.changeset(score, score_params)

    case Repo.update(changeset) do
      {:ok, score} ->
        render(conn, "show.json", score: score)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Habanero.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    score = Repo.get!(Score, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(score)

    send_resp(conn, :no_content, "")
  end
end
