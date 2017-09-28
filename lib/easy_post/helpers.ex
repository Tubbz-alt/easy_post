defmodule EasyPost.Helpers do
  @moduledoc false

  @doc "Converts a raw response body into a specified resource"
  def into(raw_body, resource_module) do
    body =
      raw_body
      |> Enum.map(fn {k, v} -> {String.to_atom(k), v} end)
      |> Enum.into(%{})

    struct(resource_module, body)
  end

  def mode_field(data, key),
    do: Map.update!(data, key, &String.to_existing_atom/1)

  def date_field(data, key) do
    Map.update!(data, key, fn val ->
      case DateTime.from_iso8601(val) do
        {:ok, date_time, _} -> date_time
        {:error, _} -> nil
      end
    end)
  end
end
