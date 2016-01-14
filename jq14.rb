class Jq14 < Formula
  desc "Lightweight and flexible command-line JSON processor"
  homepage "https://stedolan.github.io/jq/"
  url "https://github.com/stedolan/jq/releases/download/jq-1.4/jq-1.4.tar.gz"
  sha256 "998c41babeb57b4304e65b4eb73094279b3ab1e63801b6b4bddd487ce009b39d"

  head do
    url "https://github.com/stedolan/jq.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "oniguruma"
  depends_on "bison" => :build

  def install
    system "autoreconf", "-iv" unless build.stable?
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_equal "2\n", pipe_output("#{bin}/jq .bar", '{"foo":1, "bar":2}')
  end
end

