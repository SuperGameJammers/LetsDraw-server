defmodule Habanero.SubjectController do
  use Habanero.Web, :controller
  alias Habanero.Subject

  plug :scrub_params, "subject" when action in [:create, :update]

  def index(conn, _params) do
    subjects = Repo.all(Subject)
    render(conn, "index.json", subjects: subjects)
  end

  def create(conn, %{"subject" => subject_params}) do
    img = parse_img(subject_params)
    subject_params = Map.put(subject_params, "img_url", img)
    changeset = Subject.changeset(%Subject{}, subject_params)

    case Repo.insert(changeset) do
      {:ok, subject} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", subject_path(conn, :show, subject))
        |> render("show.json", subject: subject)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Habanero.ChangesetView, "error.json", changeset: changeset)
    end
  end

  defp parse_img(subject_params) do
    img = subject_params["img"]
       |> Base.decode64!
    File.write("./priv/tmp/#{subject_params["name"]}.png", img)

    %Plug.Upload{content_type: "image/png", 
                 filename: "#{subject_params["name"]}.png", 
                 path: "./priv/tmp/#{subject_params["name"]}.png"}
  end

  def show(conn, %{"id" => id}) do
    subject = Repo.get!(Subject, id)
    render(conn, "show.json", subject: subject)
  end

  def update(conn, %{"id" => id, "subject" => subject_params}) do
    subject = Repo.get!(Subject, id)
    changeset = Subject.changeset(subject, subject_params)

    case Repo.update(changeset) do
      {:ok, subject} ->
        render(conn, "show.json", subject: subject)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Habanero.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    subject = Repo.get!(Subject, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(subject)

    send_resp(conn, :no_content, "")
  end
end
