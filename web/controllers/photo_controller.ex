require Elixirer.QiniuService

defmodule Elixirer.PhotoController do
  use Elixirer.Web, :controller

  alias Elixirer.Photo

  def create(conn, %{"files" => [plgu_upload]}) do
    photo_name = plgu_upload.filename
    photo_key = Elixirer.QiniuService.photo_process(plgu_upload)

    render(conn, "create.json", name: photo_name, url: Photo.remote_url(photo_key))
  end
end
