{ stdenv, buildGoPackage, fetchFromGitHub, libvirt, pkgconfig, makeWrapper, cdrtools }:

# USAGE:
# install the following package globally or in nix-shell:
#
#   (terraform.withPlugins (old: [terraform-provider-libvirt]))
#
# configuration.nix:
#
#   virtualisation.libvirtd.enable = true;
#
# terraform-provider-libvirt does not manage pools at the moment:
#
#   $ virsh --connect "qemu:///system" pool-define-as default dir - - - - /var/lib/libvirt/images
#   $ virsh --connect "qemu:///system" pool-start default
#
# pick an example from (i.e ubuntu):
# https://github.com/dmacvicar/terraform-provider-libvirt/tree/master/examples

buildGoPackage rec {
  name = "terraform-provider-libvirt-${version}";
  version = "0.4";

  goPackagePath = "github.com/dmacvicar/terraform-provider-libvirt";

  src = fetchFromGitHub {
    owner = "dmacvicar";
    repo = "terraform-provider-libvirt";
    rev = "v${version}";
    sha256 = "05jkjp1kis4ncryv34pkb9cz2yhzbwg62x9qmlqsqlxwz9hqny3r";
  };

  buildInputs = [ libvirt pkgconfig makeWrapper ];

  # mkisofs needed to create ISOs holding cloud-init data,
  # and wrapped to terraform via deecb4c1aab780047d79978c636eeb879dd68630
  propagatedBuildInputs = [ cdrtools ];

  meta = with stdenv.lib; {
    homepage = https://github.com/dmacvicar/terraform-provider-libvirt;
    description = "Terraform provider for libvirt";
    platforms = platforms.linux;
    license = licenses.asl20;
    maintainers = with maintainers; [ mic92 ];
  };
}

