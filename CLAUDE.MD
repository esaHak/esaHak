# Project: esahakulinen.fi

Bilingual (Finnish + English) personal portfolio and blog site built with Jekyll and jekyll-polyglot, deployed via GitHub Actions to GitHub Pages. Showcases digital marketing expertise, projects, and insights.

## Commands

- `bundle install`: Install Ruby dependencies
- `bundle exec jekyll serve`: Local dev server at http://localhost:4000
- `bundle exec jekyll serve --livereload`: Dev server with auto-refresh
- `bundle exec jekyll build --verbose`: Debug build issues

## Before You Start Working

- Read this file (CLAUDE.md) fully first. It points to everything else you need.
- Read CONTEXT.md for architecture, collections, and design system details
- Read the relevant subdirectory CLAUDE.md for local conventions
- Read the relevant docs/ files for domain-specific knowledge
- If any of these files don't exist yet, that's fine; create them as you work

## Multi-language

Finnish is the default language, served at root URLs. English lives under `/en/`. Every content file needs a `lang` field in front matter (`fi` or `en`). UI strings live in `_data/fi/strings.yml` and `_data/en/strings.yml`; templates access them via `site.data[site.active_lang].strings`. When adding new content, create both language versions. When adding new UI text, add the key to both string files.

### Localized URL Slugs

Finnish pages use Finnish URL paths; English pages use English paths. Polyglot adds `/en/` prefix automatically for non-default language.

Finnish: `/`, `/blogi/`, `/projektit/`, `/tietoa/`, `/blogi/tervetuloa/`, `/projektit/portfoliosivusto/`
English: `/en/`, `/en/blog/`, `/en/projects/`, `/en/about/`, `/en/blog/welcome/`, `/en/projects/portfolio-website/`

Navigation URLs are stored in `nav_url_*` keys in both string files (e.g., `strings.nav_url_blog` returns `/blogi/` for Finnish, `/blog/` for English).

### Twin Field and Language Switcher

Because Finnish and English pages have different URL slugs, polyglot cannot pair them automatically by permalink. Instead, each content file has a `twin` field in front matter that points to the other language version's permalink. The language switcher in `header.html` reads `page.twin` to build the correct cross-language link.

Example: Finnish post has `permalink: /blogi/tervetuloa/` and `twin: /blog/welcome/`. English post has `permalink: /blog/welcome/` and `twin: /blogi/tervetuloa/`.

### Blog Post Permalinks

The `_config.yml` default permalink pattern (`/blog/:title/`) applies to the default language (Finnish), which is wrong for Finnish posts. Therefore, every blog post MUST have an explicit `permalink` in front matter: `/blogi/slug/` for Finnish, `/blog/slug/` for English. See CONTENT_GUIDE.md for the full template.

## Key Files

- `_config.yml`: Jekyll configuration (collections, plugins, defaults, excludes, polyglot settings)
- `CONTEXT.md`: Architecture decisions, design system, deployment workflow
- `CONTENT_GUIDE.md`: Detailed content creation instructions and templates
- `_data/fi/strings.yml`: Finnish UI strings for all templates
- `_data/en/strings.yml`: English UI strings for all templates
- `assets/css/_variables.css`: Design tokens (colors, spacing, typography)
- `assets/css/main.css`: Master stylesheet (imports all atomic modules)
- `.github/workflows/jekyll.yml`: Custom GitHub Actions deployment workflow

## Iterative Context: Recognizing When to Save

This project is maintained iteratively across sessions. Each session builds on the context left by the previous one. You must actively monitor whether your work has changed something a future agent would need to know.

If you have done any of the following, the context files are likely stale and need updating:

- Changed how URLs, permalinks, or routing work
- Added, renamed, or removed files that other files reference
- Introduced a new pattern, convention, or dependency
- Discovered a gotcha or workaround that is not yet documented
- Changed the build process, deployment, or plugin configuration
- Modified the "Before You Start Working" reading list itself (e.g., added a new doc that future agents should read)

When you notice this, ask the user whether they want to save context before ending the session. Do not silently let stale documentation persist. The cost of a future session starting with wrong assumptions is much higher than the cost of a context save.

## After You Finish Working

This file (CLAUDE.md) is the single most important document to keep up to date. It is the first thing any new session reads, and if it falls behind the actual state of the project, future sessions will start with wrong assumptions. Treat updating it as a required step, not an afterthought.

This instruction is recursive: if you change how the project works, update this file so that the next session after yours also knows to keep it current. The chain of context depends on every session doing its part. If you add a new document that future agents should read, add it to the "Before You Start Working" list and the "Key Files" list. If you change which documents matter, update those lists so the next agent reads the right things.

Run /project:save-context, or manually:
1. Update this CLAUDE.md if anything about the project overview, key files, multi-language setup, or rules changed
2. Update CONTEXT.md if architecture or design system changed
3. Update the relevant subdirectory CLAUDE.md if you established new patterns
4. Update docs/ with findings, decisions, or audit results
5. If you discovered a gotcha, add it to CONTEXT.md Section 17 (Known Gotchas)
6. If you added a new file that future agents need, add it to "Before You Start Working" and "Key Files" above

## Rules (also in .claude/rules/)

- No em dashes in any output
- Never commit _site/ directory; GitHub Pages builds it
- CSS changes only in assets/css/, never in _site/
- Test locally with `bundle exec jekyll serve` before pushing
- Staging branch for development; main branch triggers deployment
- Never force-push main
- Every content file must have `lang: fi` or `lang: en` in front matter
- New UI text requires entries in both `_data/fi/strings.yml` and `_data/en/strings.yml`
- Published content should have both Finnish and English versions
