require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php53Uploadprogress < AbstractPhp53Extension
  init
  homepage 'http://pecl.php.net/package/uploadprogress'
  url 'http://pecl.php.net/get/uploadprogress-1.0.3.1.tgz'
  sha1 '5fd50a1d5d3ee485e31e16d76b686873125e8dec'
  head 'https://svn.php.net/repository/pecl/uploadprogress/trunk/', :using => :svn

  depends_on 'pcre'

  def install
    Dir.chdir "uploadprogress-#{version}" unless build.head?

    # See https://github.com/mxcl/homebrew/pull/5947
    ENV.universal_binary

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/uploadprogress.so"
    write_config_file unless build.include? "without-config-file"
  end
end
