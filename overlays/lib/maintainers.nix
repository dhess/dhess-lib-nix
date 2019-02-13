self: super:

let

  selfMaintainers = (import ../../lib/maintainers) { pkgs = super; };

in
{
  lib = (super.lib or {}) // {
    maintainers = (super.lib.maintainers or {}) // selfMaintainers;
  };
}
