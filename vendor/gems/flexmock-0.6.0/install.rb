require 'rbconfig'
require 'find'
require 'ftools'

include Config

def indir(newdir)
  olddir = Dir.pwd
  Dir.chdir(newdir)
  yield
ensure
  Dir.chdir(olddir)
end

$ruby = CONFIG['ruby_install_name']
$sitedir = CONFIG["sitelibdir"]

unless $sitedir
  version = CONFIG["MAJOR"]+"."+CONFIG["MINOR"]
  $libdir = File.join(CONFIG["libdir"], "ruby", version)
  $sitedir = $:.find {|x| x =~ /site_ruby/}
  if !$sitedir
    $sitedir = File.join($libdir, "site_ruby")
  elsif $sitedir !~ Regexp.quote(version)
    $sitedir = File.join($sitedir, version)
  end
end

# The library files

file = 'flexmock.rb'

indir('lib') do
  Dir['**/*.rb'].each do |file|
    File::install(
      file,
      File.join($sitedir, file),
      0644,
      true)
  end
end


