require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php53Gearman < AbstractPhp53Extension
  init
  homepage 'http://pecl.php.net/package/gearman'
  url 'http://pecl.php.net/get/gearman-1.0.2.tgz'
  sha1 '6b75248d9eb8776a640639bfdffb0c06e0e594ad'
  head 'https://svn.php.net/repository/pecl/gearman/trunk/', :using => :svn

  depends_on 'gearman'

  def install
    Dir.chdir "gearman-#{version}" unless build.head?

    # See https://github.com/mxcl/homebrew/pull/5947
    ENV.universal_binary

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-gearman=#{Formula.factory('gearman').prefix}"
    system "make"
    prefix.install "modules/gearman.so"
    write_config_file unless build.include? "without-config-file"
  end
end
