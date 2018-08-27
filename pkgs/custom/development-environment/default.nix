{stdenv, fetchgit} :
stdenv.mkDerivation {
  name = "development-environment";
  src = fetchgit {
    url = "https://github.com/nextmoose/development-environment.git";
    rev = "30d5db9b1d9db32bfbb0cc8106997744d63b3f7d";
    sha256 = "1i6vbjr3aybr2bd1nc7yghqnv2j9f0iwpq0q5kbx2q2c4vrhy94n";
  };
  installPhase = ''
    mkdir $out/bin &&
        cp launch.sh $out/bin/launch-development-environment &&
	chmod 0555 $out/bin/launch-development-environment
  '';
  postInstallPhase = ''
    EXE=$out/bin/launch-development-environment &&
        mkdir $out/share &&
    	mkdir $out/share/bash-completion &&
    	mkdir $out/share/bash-completion/completions
    	cp completion.sh > $out/share/bash-completion/completions/launch-development-environment
    '';
}