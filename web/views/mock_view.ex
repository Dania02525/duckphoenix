defmodule Duckphoenix.MockView do
  use Duckphoenix.Web, :view

  def render("index.json", %{mocks: mocks}) do
    %{data: render_many(mocks, Duckphoenix.MockView, "mock.json")}
  end

  def render("show.json", %{mock: mock}) do
    %{data: render_one(mock, Duckphoenix.MockView, "mock.json")}
  end

  def render("mock.json", %{mock: mock}) do
    Map.merge(%{id: mock.id}, mock.data)
  end
end
