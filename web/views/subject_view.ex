defmodule Habanero.SubjectView do
  use Habanero.Web, :view

  def render("index.json", %{subjects: subjects}) do
    %{data: render_many(subjects, Habanero.SubjectView, "subject.json")}
  end

  def render("show.json", %{subject: subject}) do
    %{data: render_one(subject, Habanero.SubjectView, "subject.json")}
  end

  def render("subject.json", %{subject: subject}) do
    %{id: subject.id,
      name: subject.name,
      img_url: subject.img_url,
      complexity: subject.complexity}
  end
end
