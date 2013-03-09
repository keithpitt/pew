Lol, no rubygems or bundler.

```bash
RUBYOPT="--disable=gem -I~/path/to/fundler/lib" bin/rails server
RUBYOPT="--disable=gem" fundler exec rails server
```
