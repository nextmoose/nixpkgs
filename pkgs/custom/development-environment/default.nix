{stdenv, fetchgit} :
stdenv.mkDerivation {
  name = "development-environment";
  src = fetchgit {
    url = "https://github.com/nextmoose/development-environment.git";
    rev = "1d5eba74faba3dce85ade6b2d84542e40ed7631b";
    sha256 = "1i6vbjr3aybr2bd1nc7yghqnv2j9f0iwpq0q5kbx2q2c4vrhy94n";
  };
  installPhase = ''
    mkdir -p ${out}/bin &&
        cp launch.sh ${out}/launch-development-environment &&
	chmod 0555 ${out}/launch-development-environment
  '';
};