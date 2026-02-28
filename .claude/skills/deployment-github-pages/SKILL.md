---
name: deployment-github-pages
description: Activate when deploying, merging to main, checking build status,
  or troubleshooting GitHub Pages. Triggers on "deploy", "publish", "go live",
  "merge to main", "build error", "GitHub Pages".
---

# Deployment: Project Context

## Before Starting

1. Read CONTEXT.md Section 7 for deployment workflow
2. Read .claude/rules/jekyll-safety.md and .claude/rules/git-workflow.md
3. Read docs/deployment/ for previous deployment notes

## Project-Specific Context

- Staging branch for development; main branch triggers GitHub Pages build
- Local testing: `bundle exec jekyll serve`
- _site/ is gitignored (GitHub Pages rebuilds it)
- CNAME file in repo root maps to esahakulinen.fi
- _config.yml excludes: .claude/, docs/, CONTEXT.md, CONTENT_GUIDE.md, README.md, Gemfile files
- Plugins must be GitHub Pages compatible

## After Completing Work

1. Update docs/deployment/ with any build issues encountered and their solutions
2. Update CONTEXT.md Section 13 if a new gotcha was discovered
