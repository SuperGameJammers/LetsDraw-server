defmodule Habanero.ScoreView do
  use Habanero.Web, :view

  def render("index.json", %{scores: scores}) do
    %{data: render_many(scores, Habanero.ScoreView, "score.json")}
  end

  def render("show.json", %{score: score}) do
    %{data: render_one(score, Habanero.ScoreView, "score.json")}
  end

  def render("score.json", %{score: score}) do
    %{id: score.id,
      drawing_id: score.drawing_id,
      rate: score.rate,
      img_url: score.img_url}
  end
end
