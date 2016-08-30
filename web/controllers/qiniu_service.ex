require Qiniu

defmodule Elixirer.QiniuService do
  import Ecto.Changeset

  alias Elixirer.Repo
  alias Elixirer.Photo

  # def init(opts) do
  #   Keyword.fetch!(opts, :repo)
  # end

  # def call(conn, repo) do

  # end

  # for %Plug.Upload
  def photo_process(params) do
    plug_upload = params
    photo = sync(plug_upload)

    try do
      Repo.insert(%Photo{name: plug_upload.filename, key: photo["key"]})
    rescue
      Ecto.ConstraintError -> 'Existed'
    end

    photo["key"]
  end

  # for embed params, e.g. {user: name, avatar: %Plug.Upload}
  def photo_process(params, field) do
    plug_upload = Map.get(params, Atom.to_string(field))

    new = if is_nil(plug_upload), do: [], else: sync(plug_upload)

    case new do
      []    -> params
      is_map ->
        Repo.insert %Photo{name: plug_upload.filename, key: new["key"]}
        Map.put(params, Atom.to_string(field), new["key"])
    end
  end

  def sync(plug_upload) do
    policy = Qiniu.PutPolicy.build("elixirer-dev")

    real_sync(policy, plug_upload.path)
  end

  def real_sync(policy \\ Qiniu.PutPolicy.build("elixirer-dev"), file_path) do
    case Qiniu.Uploader.upload policy, file_path do
      %HTTPoison.Response{status_code: 200, body: body} ->
        body
      %HTTPoison.Response{status_code: 404} ->
        IO.puts "Not found :("
      %HTTPoison.Error{reason: reason} ->
        IO.inspect reason
    end
  end
end