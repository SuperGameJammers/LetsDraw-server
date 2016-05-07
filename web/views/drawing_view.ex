defmodule Habanero.DrawingView do
  use Habanero.Web, :view

  def render("index.json", %{drawings: drawings}) do
    %{data: render_many(drawings, Habanero.DrawingView, "drawing.json")}
  end

  def render("show.json", %{drawing: drawing}) do
    %{data: render_one(drawing, Habanero.DrawingView, "drawing.json")}
  end

  def render("drawing.json", %{drawing: drawing}) do
    %{id: drawing.id,
      subject_id: drawing.subject_id,
      img_url: drawing.img_url,
      name: drawing.name
    }
  end
end
