Never commit _site/ directory to git. GitHub Pages rebuilds it on deploy.

CSS changes must be made in assets/css/ source files, never in _site/.

New content must follow the patterns in CONTENT_GUIDE.md.

Images go in assets/images/ under the appropriate subdirectory (author/, blog/, og/, pages/, projects/).

Always test locally with `bundle exec jekyll serve` before pushing changes.

If a build fails, check: valid YAML front matter, valid Liquid syntax, Jekyll version compatibility.
