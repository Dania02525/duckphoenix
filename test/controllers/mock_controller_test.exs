defmodule Duckphoenix.MockControllerTest do
  use Duckphoenix.ConnCase

  alias Duckphoenix.Resource
  @valid_attrs %{resource: "some content", resource_id: 42, response: %{}}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, "/api/widgets"
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    mock = Repo.insert! %Resource{type: "widgets", data: %{foo: "bar"}}
    conn = get conn, "/api/widgets/" <> Integer.to_string(mock.id)
    assert json_response(conn, 200)["data"] == %{"id" => mock.id, "foo" => "bar"}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, "/api/widgets/999"
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, "/api/widgets", %{data: %{foo: "bar"}}
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Resource, %{data: %{foo: "bar"}})
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    mock = Repo.insert! %Resource{type: "widgets", data: %{foo: "bar"}}
    conn = put conn, "/api/widgets/" <> Integer.to_string(mock.id), %{data: %{biz: "baz"}}
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Resource, %{data: %{biz: "baz"}})
  end

  test "deletes chosen resource", %{conn: conn} do
    mock = Repo.insert! %Resource{type: "widgets"}
    conn = delete conn, "/api/widgets/" <> Integer.to_string(mock.id)
    assert response(conn, 204)
    refute Repo.get(Resource, mock.id)
  end
end
