defmodule TrackerWeb.Router do
  use TrackerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :get_current_user
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

   def get_current_user(conn, _params) do
    # TODO: Move this function out of the router module.
    user_id = get_session(conn, :user_id)
    user = Tracker.Accounts.get_user(user_id || -1)
    assign(conn, :current_user, user)
  end

  pipeline :api do
    plug :accepts, ["json"]
  end
 
  
  scope "/", TrackerWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/home", PageController, :userhome
    resources "/users", UserController
    get "/taskdetails/time", TaskTrackersController, :editime
    resources "/taskdetails", TaskTrackersController
    get "/tasks", PageController, :tasks
    post "/session", SessionController, :create
    delete "/session", SessionController, :delete
  end

  scope "api/v1", TrackerWeb do
    pipe_through :api
    resources "/timeblocks", TimeBlockController, except: [:new, :edit]
    put "/timeblocks", TimeBlockController, :update
    delete "/timeblocks", TimeBlockController, :delete
    post "/timeblocks/delete", TimeBlockController, :delete
    post "/timeblocks/update", TimeBlockController, :updatetime
  end
  # Other scopes may use custom stacks.
  # scope "/api", TrackerWeb do
  #   pipe_through :api
  # end
end
