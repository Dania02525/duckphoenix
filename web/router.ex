defmodule Duckphoenix.Router do
  use Duckphoenix.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers

  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Plug.Parsers, parsers: [:urlencoded, :json],
                   pass:  ["text/*"],
                   json_decoder: Poison
    plug PlugMock
  end

  scope "/api", Duckphoenix do
    pipe_through :api
    get "/*path", MockController, :get_handler
    post "/*path", MockController, :post_handler
    put "/*path", MockController, :post_handler
    delete "/*path", MockController, :delete_handler
  end

  scope "/", Duckphoenix do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/resources", ResourceController
  end
end
