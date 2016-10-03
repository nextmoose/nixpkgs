{ stdenv, fetchurl
, xorg, gtk2, atk, glib, pango, gdk_pixbuf, cairo, freetype, fontconfig
, gnome2, dbus, nss, nspr, alsaLib, cups, expat, udev, libnotify }:

stdenv.mkDerivation rec {
  version = "0.4.4";
  name = "rambox-${version}";
  src = fetchurl {
    url = "https://github.com/saenzramiro/rambox/releases/download/${version}/Rambox-${version}-x64.tar.gz";
    sha256 = "05xwabwij7fyifrypahcplymz46k01rzrwgp5gn79hh023w259i0";
  };

  phases = [ "unpackPhase" "installPhase" ];

  deps = with xorg; [
   gtk2 atk glib pango gdk_pixbuf cairo freetype fontconfig dbus
   libXi libXcursor libXdamage libXrandr libXcomposite libXext libXfixes
   libXrender libX11 libXtst libXScrnSaver gnome2.GConf nss nspr alsaLib
   cups expat stdenv.cc.cc

   udev libnotify
  ];

  installPhase = ''
    patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" Rambox
    patchelf --set-rpath "$out/share/rambox:${stdenv.lib.makeLibraryPath deps}" Rambox

    mkdir -p $out/bin $out/share/rambox
    cp -r * $out/share/rambox
    ln -s $out/share/rambox/Rambox $out/bin
  '';

  meta = with stdenv.lib; {
    description = "Free and Open Source messaging and emailing app that combines common web applications into one";
    homepage = http://rambox.pro;
    license = licenses.mit;
    platforms = ["x86_64-linux"];
  };
}
