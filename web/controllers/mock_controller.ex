defmodule Duckphoenix.MockController do
  use Duckphoenix.Web, :controller

  alias Duckphoenix.Resource

  plug :scrub_params, "mock" when action in [:create, :update]

  def get_handler(conn, _params) do
    type = conn.assigns[:type]
    case conn.assigns[:id] do
      nil ->
        q = from r in Resource,
            where: r.type == ^type,
            select: r
        mocks = Repo.all(q)
        render(conn, "index.json", mocks: mocks)
      id ->
        mock = Repo.get_by!(Resource, id: id, type: conn.assigns[:type])
        render(conn, "show.json", mock: mock)
    end
  end

  def post_handler(conn, _params) do
    type = conn.assigns[:type]
    case conn.assigns[:id] do
      nil ->
        changeset = Resource.changeset(%Resource{}, %{"data" => conn.body_params["data"], "type" => type})
        case Repo.insert(changeset) do
          {:ok, resource} ->
            json conn |> put_status(201), %{message: "ok", data: %{id: resource.id, data: resource.data}}
          {:error, changeset} ->
            json conn |> put_status(400), %{message: "error #{inspect changeset.errors}"}
        end
      id ->
        mock = Repo.get_by!(Resource, id: id, type: type)
        changeset = Resource.changeset(mock, %{"data" => conn.body_params["data"], "type" => type})
        case Repo.update(changeset) do
          {:ok, resource} ->
            json conn |> put_status(200), %{message: "ok", data: %{id: resource.id, data: resource.data}}
          {:error, changeset} ->
            json conn |> put_status(400), %{message: "error"}
        end
    end
  end

  def delete_handler(conn, _params) do
    mock = Repo.get_by!(Resource, id: conn.assigns[:id], type: conn.assigns[:type])
    Repo.delete!(mock)
    json conn |> put_status(204), %{message: "ok"}
  end
end
