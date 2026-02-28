# Project: esahakulinen.fi

Personal portfolio and blog site built with Jekyll and hosted on GitHub Pages. Showcases digital marketing expertise, projects, and insights.

## Commands

- `bundle install`: Install Ruby dependencies
- `bundle exec jekyll serve`: Local dev server at http://localhost:4000
- `bundle exec jekyll serve --livereload`: Dev server with auto-refresh
- `bundle exec jekyll build --verbose`: Debug build issues

## Before You Start Working

- Read CONTEXT.md for architecture, collections, and design system details
- Read the relevant subdirectory CLAUDE.md for local conventions
- Read the relevant docs/ files for domain-specific knowledge
- If any of these files don't exist yet, that's fine; create them as you work

## Key Files

- `_config.yml`: Jekyll configuration (collections, plugins, defaults, excludes)
- `CONTEXT.md`: Architecture decisions, design system, deployment workflow
- `CONTENT_GUIDE.md`: Detailed content creation instructions and templates
- `assets/css/_variables.css`: Design tokens (colors, spacing, typography)
- `assets/css/main.css`: Master stylesheet (imports all atomic modules)

## After You Finish Working

Run /project:save-context, or manually:
1. Update CONTEXT.md if architecture or design system changed
2. Update the relevant subdirectory CLAUDE.md if you established new patterns
3. Update docs/ with findings, decisions, or audit results
4. If you discovered a gotcha, add it to CONTEXT.md Section 13

## Rules (also in .claude/rules/)

- No em dashes in any output
- Never commit _site/ directory; GitHub Pages builds it
- CSS changes only in assets/css/, never in _site/
- Test locally with `bundle exec jekyll serve` before pushing
- Staging branch for development; main branch triggers deployment
- Never force-push main
