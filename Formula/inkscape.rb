class Inkscape < Formula
  desc "Professional vector graphics editor"
  homepage "https://inkscape.org/"
  url "https://launchpad.net/inkscape/0.92.x/0.92.2/+download/inkscape-0.92.2.tar.bz2"
  mirror "https://mirrors.kernel.org/debian/pool/main/i/inkscape/inkscape_0.92.2.orig.tar.bz2"
  sha256 "a628d0e04c254e9840947e6d866974f92c68ae31631a38b94d9b65e5cd84cfd3"
  revision 1

  head do
    url "https://gitlab.com/inkscape/inkscape.git", :using => :git, :branch => "0.92.x"
  end

  depends_on "automake" => :build
  depends_on "cmake" => :build
  depends_on "libtool" => :build
  depends_on "boost-build" => :build
  depends_on "intltool" => :build
  depends_on "pkg-config" => :build
  depends_on "bdw-gc"
  depends_on "boost"
  depends_on "cairomm"
  depends_on "gettext"
  depends_on "glibmm"
  depends_on "gsl"
  depends_on "hicolor-icon-theme"
  depends_on "libsoup" # > 0.92.x
  depends_on "little-cms"
  depends_on "pango"
  depends_on "popt"
  depends_on "poppler"
  depends_on "potrace"

  depends_on "gtkmm"

  if MacOS.version < :mavericks
    fails_with :clang do
      cause "inkscape's dependencies will be built with libstdc++ and fail to link."
    end
  end

  def install
    ENV.append "LDFLAGS", "-liconv"

    system "mkdir", "build"
    Dir.chdir("build")
    system "cmake", "..", *std_cmake_args
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/inkscape", "-x"
  end
end
