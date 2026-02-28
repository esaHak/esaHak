# Architecture Reference: esahakulinen.fi

> Single source of truth for project architecture. Updated by agents as the project evolves.

## 1. Overview

Personal portfolio and blog site for Esa Hakulinen. Showcases digital marketing expertise, projects, and insights. Positioning: "building in public."

Live site: https://esahakulinen.fi
Domain: esahakulinen.fi (CNAME configured)

## 2. Technology Stack

- Static site generator: Jekyll
- Hosting: GitHub Pages
- Templating: Liquid
- Markdown processor: kramdown
- Syntax highlighting: rouge
- Styling: Custom CSS with atomic design (no preprocessor, no Tailwind)
- JavaScript: Vanilla JS, minimal (mobile nav and smooth scrolling only)
- Plugins: jekyll-feed, jekyll-seo-tag, jekyll-sitemap

## 3. Collections

Three Jekyll collections, each with its own layout and permalink pattern:

Posts (`_posts/`): Blog articles. Permalink `/blog/:title/`. Layout `post`. Filename format `YYYY-MM-DD-title-slug.md`. Front matter: title, description, date, categories, tags, read_time, image.

Projects (`_projects/`): Portfolio showcases. Permalink `/projects/:name/`. Layout `project`. Front matter: title, description, date, status (live, in-progress, experiment, archived), tagline, tech, live_url, github_url, demo_path, image, lessons, results.

SEO Pages (`_seo_pages/`): Programmatic SEO guides. Permalink `/guides/:path/`. Layout `seo_page`. Front matter: title, description, category, last_updated, keywords, related_pages, cta.

Data-driven topics also defined in `_data/seo_topics.yml` for potential programmatic generation.

## 4. CSS Design System

Atomic design pattern using plain CSS with custom properties. No build step.

Structure under `assets/css/`:
- `_variables.css`: Design tokens (colors, spacing, typography, layout, effects)
- `_base.css`: Reset and foundational styles
- `main.css`: Master stylesheet that imports all modular files

Atomic layers:
- `atoms/`: badges, buttons, icons, images, tags
- `molecules/`: nav-link, post-meta, tag-list, category-list, cta-box, tech-stack
- `organisms/`: header, footer, hero, breadcrumbs, page-header, cards (post, project, guide), post-author, post-navigation, related-posts
- `templates/`: post, project, seo-page (page-level layout styles)
- `utilities/`: helper classes

Design tokens (from _variables.css):
- Primary: #2563eb; Accent: #f59e0b; Text: #1e293b
- System font stack (sans and mono)
- Spacing scale: xs (0.25rem) through 3xl (4rem)
- Max width: 1200px; Content width: 720px

## 5. Liquid Component Library

Includes organized under `_includes/` following the same atomic pattern:

atoms/: badge, button, icon, image, meta-item, tag
molecules/: breadcrumb-item, category-list, cta-box, nav-link, post-meta, social-link, tag-list, tech-stack
organisms/: breadcrumbs, footer, guide-card, header, hero, page-header, post-author, post-card, post-navigation, project-card, related-posts

Root-level includes (legacy or shared): head.html, footer.html, nav.html, breadcrumbs.html, image.html

Layouts in `_layouts/`: default.html (base), post.html, project.html, seo_page.html

## 6. Content Front Matter Reference

See CONTENT_GUIDE.md for full templates and examples. Summary of required fields:

Posts: title (required), description (required), date (required). Optional: categories, tags, read_time, image, author.

Projects: title (required), description (required), date (required), status (required). Optional: tagline, tech, live_url, github_url, demo_path, image, lessons, results.

SEO Pages: title (required), description (required), category (required), last_updated (required), keywords (required). Optional: related_pages, cta.

## 7. Deployment

Branch strategy: `staging` for development, `main` triggers GitHub Pages build and deploy.

Workflow:
1. Work on staging branch
2. Test locally with `bundle exec jekyll serve`
3. When ready to deploy, merge staging into main
4. GitHub Pages automatically builds and deploys

Local development:
- `bundle install` to install dependencies
- `bundle exec jekyll serve` for local server at localhost:4000
- `bundle exec jekyll serve --livereload` for auto-refresh

## 8. SEO Setup

- jekyll-seo-tag: Generates meta tags, Open Graph, Twitter cards automatically from front matter
- jekyll-sitemap: Generates sitemap.xml
- jekyll-feed: Generates RSS feed at /feed.xml
- Twitter card type: summary_large_image
- Default OG image: /assets/images/og-default.png
- Google Analytics: not yet configured (placeholder in _config.yml)

## 9. Image Handling

All images in `assets/images/`, organized by type:
- `author/`: Profile images
- `blog/`: Blog post featured images
- `og/`: Open Graph social sharing images
- `pages/`: Page-level hero and decorative images
- `projects/`: Project showcase images

Preferred format: .webp
Reference in front matter: `image: /assets/images/blog/filename.webp`
Reference in Markdown: `![Alt text](/assets/images/blog/filename.webp)`

## 10. Build Exclusions

Excluded from Jekyll builds (configured in _config.yml):
README.md, Gemfile, Gemfile.lock, node_modules, vendor, .git, shell scripts (*.sh), CONTENT_GUIDE.md

Also excluded (to be added): .claude/, docs/, CONTEXT.md

## 11. Site Pages

Static HTML pages (Liquid templated):
- index.html (homepage)
- blog.html (blog listing)
- projects.html (projects listing)
- guides.html (guides listing)
- about.html (about page)

Standalone projects directory: `projects/` (for React apps, interactive demos)

## 12. Troubleshooting

Build failures: Check YAML front matter validity, Liquid syntax, Jekyll version compatibility, GitHub Pages build logs.

Local server issues: Run `bundle update`, clear cache with `rm -rf .jekyll-cache`, rebuild with `bundle exec jekyll build --verbose`.

## 13. Known Gotchas

- Never commit _site/ to git (GitHub Pages rebuilds it; .gitignore handles this)
- Clear .jekyll-cache if builds produce stale output
- GitHub Pages uses a specific set of supported plugins; not all Jekyll plugins work
- Front matter must be valid YAML; a missing closing `---` breaks the entire build
- CNAME file must stay in repo root for custom domain to work
- _config.yml must restart the local Jekyll server to pick up changes (unlike content edits which hot-reload)
- .claude/skills/ provide project context only; domain expertise belongs to the specialist agents, not the project files
