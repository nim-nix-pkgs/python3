{
  description = ''Wrapper to interface with the Python 3 interpreter'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-python3-master.flake = false;
  inputs.src-python3-master.owner = "matkuki";
  inputs.src-python3-master.ref   = "refs/heads/master";
  inputs.src-python3-master.repo  = "python3";
  inputs.src-python3-master.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-python3-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-python3-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}