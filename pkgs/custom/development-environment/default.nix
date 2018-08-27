{stdenv, fetchgit} :
stdenv.mkDerivation {
  name = "development-environment";
  src = fetchgit {
    url = "https://github.com/nextmoose/development-environment.git";
    rev = "30d5db9b1d9db32bfbb0cc8106997744d63b3f7d";
    sha256 = "0kvqrhsw6sqqzc0rn6lb4k90v093f0q7197fiadwhj90s2vk7spa";
  };
  installPhase = ''
    mkdir $out &&
        mkdir $out/bin &&
        cp launch.sh $out/bin/launch-development-environment &&
	chmod 0555 $out/bin/launch-development-environment
        mkdir $out/share &&
    	mkdir $out/share/bash-completion &&
    	mkdir $out/share/bash-completion/completions
    	cp completion.sh $out/share/bash-completion/completions/launch-development-environment
    '';
}