defmodule Habanero.DrawingView do
  use Habanero.Web, :view
  alias Habanero.DrawingImage

  def render("index.json", %{drawings: drawings}) do
    %{data: render_many(drawings, Habanero.DrawingView, "drawing.json")}
  end

  def render("show.json", %{drawing: drawing}) do
    %{data: render_one(drawing, Habanero.DrawingView, "drawing.json")}
  end

  def render("drawing.json", %{drawing: drawing}) do
    %{id: drawing.id,
      subject_id: drawing.subject_id,
      img_url: DrawingImage.url({drawing.img_url, drawing}),
      name: drawing.name,
      order: drawing.order
    }
  end
end
