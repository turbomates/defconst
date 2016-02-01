defmodule Defconst do
  defmacro __using__(_) do
    quote do
      require Defconst
      import Defconst
    end
  end

  defmacro defconst(name, value) do
    {evaluated, _} = Code.eval_quoted(value)
    escaped_value = Macro.escape(evaluated) |> Macro.escape

    if is_atom(name) do
      quote do
        defmacro unquote({name, [], nil}), do: unquote(escaped_value)
      end
    else
      quote do
        defmacro unquote(name), do: unquote(escaped_value)
      end
    end
  end
end
