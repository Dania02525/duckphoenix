defmodule Duckphoenix.ResourceControllerTest do
  use Duckphoenix.ConnCase

  alias Duckphoenix.Resource
  @valid_attrs %{data: Poison.encode!(%{foo: "bar"}), id: 42, type: "some content"}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, resource_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing resources"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, resource_path(conn, :new)
    assert html_response(conn, 200) =~ "New resource"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, resource_path(conn, :create), resource: @valid_attrs
    assert redirected_to(conn) == resource_path(conn, :index)
    assert Repo.get_by(Resource, %{type: "some content"})
  end

  test "shows chosen resource", %{conn: conn} do
    resource = Repo.insert! %Resource{}
    conn = get conn, resource_path(conn, :show, resource)
    assert html_response(conn, 200) =~ "Show resource"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, resource_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    resource = Repo.insert! %Resource{}
    conn = get conn, resource_path(conn, :edit, resource)
    assert html_response(conn, 200) =~ "Edit resource"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    resource = Repo.insert! %Resource{}
    conn = put conn, resource_path(conn, :update, resource), resource: @valid_attrs
    assert redirected_to(conn) == resource_path(conn, :show, resource)
    assert Repo.get_by(Resource, %{type: "some content"})
  end

  test "deletes chosen resource", %{conn: conn} do
    resource = Repo.insert! %Resource{}
    conn = delete conn, resource_path(conn, :delete, resource)
    assert redirected_to(conn) == resource_path(conn, :index)
    refute Repo.get(Resource, resource.id)
  end
end
