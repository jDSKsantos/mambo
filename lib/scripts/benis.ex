defmodule Benis do
  @moduledoc """
  Benisify a sentence.

  Examples:
    .benis <sentence>
  """

  use GenEvent.Behaviour

  def init(_) do
    {:ok, []}
  end

  def handle_event({:msg, {".help benis", _, {cid,_,_}}}, _) do
    Mambo.Bot.send_msg(<<?\n, @moduledoc>>, cid)
    {:ok, []}
  end

  def handle_event({:privmsg, {".help benis", _, {clid,_}}}, _) do
    Mambo.Bot.send_privmsg(<<?\n, @moduledoc>>, clid)
    {:ok, []}
  end

  def handle_event({:msg, {<<".benis ", msg :: binary>>, _, {cid,_,_}}}, _) do
    msg |> benisify |> Mambo.Bot.send_msg(cid)
    {:ok, []}
  end

  def handle_event(_, _) do
    {:ok, []}
  end

  # Helpers

  defp benisify(s) do
    String.downcase(s)
      |> String.replace(~r/x/, "cks")
      |> String.replace(~r/ing/, "in")
      |> String.replace(~r/you/, "u")
      |> String.replace(~r/oo/, String.duplicate("u", :random.uniform(5)))
      |> String.replace(~r/ck/, String.duplicate("g", :random.uniform(5)))
      |> String.replace(~r/(t+)(?=[aeiouys]|\b)/, String.duplicate("d", String.length("&") + 1))
      |> String.replace(~r/p/, "b")
      |> String.replace(~r/\bthe\b/, "da")
      |> String.replace(~r/\bc/, "g")
      |> String.replace(~r/\bis/, "are")
      |> String.replace(~r/c+(?![eiy])/, String.duplicate("g", :random.uniform(5)))
      |> String.replace(~r/k+(?=[aeiouy]|\b)/, String.duplicate("g", :random.uniform(5)))
      |> String.replace(~r/([?!.]|$)+/, (String.duplicate("&", :random.uniform(5))) <> " " <> ":DD:DDD:D:DD")
  end
end
