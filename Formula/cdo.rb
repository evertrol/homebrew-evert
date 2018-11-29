class Cdo < Formula
  desc "Climate data operators"
  homepage "https://code.mpimet.mpg.de/projects/cdo"
  url "https://code.mpimet.mpg.de/attachments/download/18911/cdo-1.9.6rc4.tar.gz"
  sha256 "c236f48f3c920a29b4e66aa3883eeb7666fc5b4ee7109b2d24f8618709f6b60b"

  depends_on "fftw"
  depends_on "grib-api"
  depends_on "hdf5"
  depends_on "libxml2"
  depends_on "netcdf"
  depends_on "udunits"

  fails_with :clang do
    cause "need gcc/g++ specifics"
  end

  def install
    system "./configure",
           "--disable-debug",
           "--disable-dependency-tracking",
           "--disable-silent-rules",
           "--prefix=#{prefix}",
           "--with-hdf5=yes",
           "--with-netcdf=yes",
           "--with-libxml2=yes",
           "--with-grib_api=yes",
           "--with-fftw3=yes",
           "--with-udunits2=yes",
           "--with-zslib=yes",
           "--with-curl=/usr"
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/cdo --version 2>&1 | head -n1")
    assert_match "Climate Data Operators version 1.9.6rc4 (http://mpimet.mpg.de/cdo)", output
  end
end
