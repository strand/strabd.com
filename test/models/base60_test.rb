require_relative "../test_helper"

describe Base60 do
  it "encodes integers" do
    Base60.encode(0).must_equal "0"
    Base60.encode(1).must_equal "1"
    Base60.encode(623).must_equal "AP"
    proc { Base60.encode(-1) }.must_raise ArgumentError
  end

  it "decodes strings" do
    Base60.decode("0").must_equal 0
    Base60.decode("1").must_equal 1
    Base60.decode("AP").must_equal 623
    proc { Base60.decode("-1") }.must_raise ArgumentError
    proc { Base60.decode("I") }.must_raise ArgumentError
    proc { Base60.decode("O") }.must_raise ArgumentError
    proc { Base60.decode("l") }.must_raise ArgumentError
  end
end