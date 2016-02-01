defmodule DefconstTest do
  use ExUnit.Case
  doctest Defconst

  defmodule Constants do
    use Defconst

    defconst :c1, 5
    defconst :c2, %{a: 2}
    defconst :c3, Enum.at([1, 2], 1)
    defconst :c4, Map.new
  end

  test "constant values" do
    require Constants

    assert Constants.c1 == 5
    assert Constants.c2 == %{a: 2}
    assert Constants.c3 == 2
    assert Constants.c4 == %{}
  end

  test "constant guards" do
    require Constants

    value = case %{} do
      Constants.c4 ->
        :ok
      _ ->
        :error
    end

    assert value == :ok
  end

  test "constant fun guards" do
    require Constants

    f = fn
      Constants.c1 -> :c1
      Constants.c2 -> :c2
      _ -> :other
    end

    assert f.(0) == :other
    assert f.(5) == :c1
    assert f.(%{a: 2}) == :c2
  end
end
