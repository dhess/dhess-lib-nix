# Based on
# https://github.com/input-output-hk/iohk-ops/blob/df01a228e559e9a504e2d8c0d18766794d34edea/jobsets/default.nix

{ nixpkgs ? <nixpkgs>
, declInput ? {}
}:

let

  dhessLibNixUri = "https://github.com/dhess/dhess-lib-nix.git";

  mkFetchGithub = value: {
    inherit value;
    type = "git";
    emailresponsible = false;
  };

  pkgs = import nixpkgs {};

  defaultSettings = {
    enabled = 1;
    hidden = false;
    keepnr = 20;
    schedulingshares = 100;
    checkinterval = 60;
    enableemail = false;
    emailoverride = "";
    nixexprpath = "jobsets/release.nix";
    nixexprinput = "dhessLibNix";
    description = "dhess-lib-nix";
    inputs = {
      dhessLibNix = mkFetchGithub "${dhessLibNixUri} master";
    };
  };

  # Build against a nixpkgs-channels repo. Run these every 3 hours so
  # that they're less likely to interfere with our own commits.
  mkNixpkgsChannels = dhessLibNixBranch: nixpkgsRev: {
    checkinterval = 60 * 60 * 3;
    inputs = {
      dhessLibNix = mkFetchGithub "${dhessLibNixUri} ${dhessLibNixBranch}";
      nixpkgs_override = mkFetchGithub "https://github.com/NixOS/nixpkgs-channels.git ${nixpkgsRev}";
    };
  };

  # Build against the nixpkgs repo. Runs less often due to nixpkgs'
  # velocity.
  mkNixpkgs = dhessLibNixBranch: nixpkgsRev: {
    checkinterval = 60 * 60 * 12;
    inputs = {
      dhessLibNix = mkFetchGithub "${dhessLibNixUri} ${dhessLibNixBranch}";
      nixpkgs_override = mkFetchGithub "https://github.com/NixOS/nixpkgs.git ${nixpkgsRev}";
    };
  };

  mainJobsets = with pkgs.lib; mapAttrs (name: settings: defaultSettings // settings) (rec {
    master = {};
    nixos-unstable = mkNixpkgsChannels "master" "nixos-unstable";
    nixpkgs-unstable = mkNixpkgsChannels "master" "nixpkgs-unstable";
    nixpkgs = mkNixpkgs "master" "master";
  });

  jobsetsAttrs = mainJobsets;

  jobsetJson = pkgs.writeText "spec.json" (builtins.toJSON jobsetsAttrs);

in {
  jobsets = with pkgs.lib; pkgs.runCommand "spec.json" {} ''
    cat <<EOF
    ${builtins.toJSON declInput}
    EOF
    cp ${jobsetJson} $out
  '';
}
