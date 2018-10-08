import ./make-test.nix ({ pkgs, ...} : {
  name = "libfoo";
  meta = with pkgs.stdenv.lib.maintainers; {
    maintainers = [ nequissimus offline ];
  };

  nodes = {
    libfoo =
      { pkgs, ... }:
        {
          users.users = {
            noprivs = {
              isNormalUser = true;
              description = "Can't access the docker daemon";
              password = "foobar";
            };

            hasprivs = {
              isNormalUser = true;
              description = "Can access the docker daemon";
              password = "foobar";
              extraGroups = [ "docker" ];
	      packages = [ pkgs.libfoo ];
            };
          };
        };
    };

  testScript = ''
    $libfoo->start();
    $libfoo->waitForUnit("multi-user.target");
    $libfoo->succeed("su - hasprivs -c 'hello'");
    $libfoo->fail("su - noprivs -c 'hello'");
    $libfoo->succeed("[ 'world' == `su - hasprivs -c 'hello --greeting world'` ]");
    $libfoo->shutdown();
  '';
})
