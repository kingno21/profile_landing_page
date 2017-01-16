%w(
  .ruby-version
  .rbenv-vars
  index/restart.txt
  index/caching-dev.txt
).each { |path| Spring.watch(path) }
