require "functional/helper"

describe "inspec supermarket" do
  include FunctionalHelper

  it "help" do
    out = inspec("supermarket help")

    _(out.stdout).must_include "inspec supermarket exec PROFILE"

    _(out.stderr).must_equal ""

    assert_exit_code 0, out
  end

  it "info" do
    out = inspec("supermarket info dev-sec/ssh-baseline")

    _(out.stdout).must_include "name: \e[0m  ssh-baseline"

    _(out.stderr).must_equal ""

    assert_exit_code 0, out
  end

  it "supermarket exec" do
    if is_windows?
      out = inspec("supermarket exec dev-sec/windows-patch-baseline")
    else
      out = inspec("supermarket exec dev-sec/ssh-baseline")
    end

    _(out.stdout).must_include "Profile Summary"
    _(out.stdout).must_include "Test Summary"

    _(out.stderr).must_equal ""
    skip_windows! # Breakage confirmed
    assert_exit_code 100, out
  end
end
