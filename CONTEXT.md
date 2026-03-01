# Architecture Reference: esahakulinen.fi

> Single source of truth for project architecture. Updated by agents as the project evolves.

## 1. Overview

Personal portfolio and blog site for Esa Hakulinen. Digital marketer sharing projects and ideas. Bilingual: Finnish (default) and English.

Live site: https://esahakulinen.fi
Domain: esahakulinen.fi (CNAME configured)

## 2. Technology Stack

- Static site generator: Jekyll 4.4.1
- Hosting: GitHub Pages (via custom GitHub Actions workflow)
- Templating: Liquid
- Markdown processor: kramdown
- Syntax highlighting: rouge
- Styling: Custom CSS with atomic design (no preprocessor, no Tailwind, no CSS framework)
- JavaScript: Vanilla JS, minimal (mobile nav and smooth scrolling only)
- Plugins: jekyll-feed (0.17.0), jekyll-polyglot (multi-language), jekyll-seo-tag (2.8.0). Note: jekyll-sitemap was removed; a custom sitemap.xml Liquid template is used instead.
- Development tool: Claude Code (used to build and maintain the site)

## 3. Multi-language Setup

The site is bilingual: Finnish and English. Powered by jekyll-polyglot.

### Configuration (_config.yml)

- `languages: ["fi", "en"]`
- `default_lang: "fi"` (Finnish is the default, served at root URLs)
- `exclude_from_localization: ["javascript", "images", "css", "assets", "sitemap.xml", "favicon.ico", "site.webmanifest", "CNAME"]`
- `parallel_localization: true`
- `sass: sourcemap: never` (required for Jekyll 4 + polyglot)

### URL structure

Finnish content uses Finnish slugs at root: `/`, `/blogi/`, `/projektit/`, `/tietoa/`
English content uses English slugs under `/en/`: `/en/`, `/en/blog/`, `/en/projects/`, `/en/about/`

Blog post URLs also include the language-specific blog prefix:
- Finnish: `/blogi/tervetuloa/`, `/blogi/slug/`
- English: `/en/blog/welcome/`, `/en/blog/slug/`

Project URLs follow the same pattern:
- Finnish: `/projektit/portfoliosivusto/`
- English: `/en/projects/portfolio-website/`

Navigation URLs are stored as `nav_url_*` keys in the string data files so templates can reference language-appropriate paths (e.g., `strings.nav_url_blog` returns `/blogi/` for Finnish, `/blog/` for English).

### How content files are organized

Every content file (post, project, page) must have `lang: fi` or `lang: en` in its front matter. Polyglot uses this to decide which language build the file belongs to.

File naming convention for language pairs:
- Pages: `index.html` (fi) + `index-en.html` (en), `about-fi.html` (fi) + `about.html` (en)
- Posts: `2025-01-20-welcome-building-in-public.md` (en) + `2025-01-20-welcome-building-in-public-fi.md` (fi)
- Projects: `portfolio-website.md` (en) + `portfolio-website-fi.md` (fi)

Because Finnish and English pages have different URL slugs (e.g., `/blogi/` vs `/blog/`), polyglot cannot pair them by permalink. Instead, each content file has a `twin` front matter field pointing to the other language version's permalink. The language switcher reads `page.twin` to construct cross-language links. Pages without a `twin` field fall back to URL-based prefix swapping.

### UI string localization

All user-facing UI text (navigation labels, button text, status badges, section headings, breadcrumbs, footer labels) is stored in data files, not hardcoded in templates.

- `_data/fi/strings.yml`: Finnish translations
- `_data/en/strings.yml`: English translations

Templates access strings via: `{% assign strings = site.data[site.active_lang].strings %}` then use `{{ strings.nav_home }}`, `{{ strings.btn_view_projects }}`, etc.

When adding new UI text to any template, always add the key to both strings files. Never hardcode display text in templates.

### Language switcher

The navigation includes a language switcher that shows "In English" on Finnish pages and "Suomeksi" on English pages.

If the page has a `twin` front matter field, the switcher uses that value directly. Otherwise, it falls back to URL manipulation (prepending `/en` or stripping `/en/` prefix).

CRITICAL: The switcher links must be wrapped in `{% static_href %}...{% endstatic_href %}` tags. Without this, polyglot's post-processing rewrites all relative URLs in rendered HTML to add the language prefix, which breaks the cross-language links. This is defined in `_includes/organisms/header.html`.

On desktop, the switcher sits at the far right of the nav bar. On mobile, it appears at the bottom of the hamburger menu.

### Hreflang tags

`{{ I18n_Headers }}` (double braces, capital H in Headers) in head.html generates `<link rel="alternate" hreflang="...">` tags automatically, telling search engines about the language variants of each page. Note: using `{% %}` block tags or lowercase will cause a build error.

### Adding new content in both languages

To add a new blog post in both languages:
1. Create `_posts/YYYY-MM-DD-slug.md` with `lang: en`, `permalink: /blog/slug/`, and `twin: /blogi/slug/`
2. Create `_posts/YYYY-MM-DD-slug-fi.md` with `lang: fi`, `permalink: /blogi/slug/`, and `twin: /blog/slug/`
3. Every post MUST have an explicit permalink (the _config.yml default `/blog/:title/` applies to Finnish, which is wrong for Finnish posts)

To add a new project in both languages:
1. Create `_projects/name.md` with `lang: en`
2. Create `_projects/name-fi.md` with `lang: fi`

Content does not need to be translated simultaneously. If only one language version exists, polyglot will serve that language's version and fall back to the default language for the other.

### Polyglot Liquid variables

- `site.active_lang`: the language currently being built ("fi" or "en")
- `site.default_lang`: always "fi"
- `site.languages`: ["fi", "en"]

## 4. Collections

Two active Jekyll collections:

Posts (`_posts/`): Blog articles. Permalink `/blog/:title/` (individual posts can override with `permalink` in front matter). Layout `post`. Filename format `YYYY-MM-DD-title-slug.md`. Front matter: title, description, date, categories, tags, read_time, image, author, lang.

Projects (`_projects/`): Portfolio showcases. Permalink `/projects/:name/`. Layout `project`. Front matter: title, description, date, status (live, in-progress, experiment, archived), tagline, tech, live_url, github_url, demo_path, image, lessons, results, lang.

SEO Pages (`_seo_pages/`): Currently disabled (`output: false` in _config.yml). Files remain in the repo for future use. Layout `seo_page`.

Data-driven topics also defined in `_data/seo_topics.yml` for potential programmatic generation.

## 5. CSS Design System

Atomic design pattern using plain CSS with custom properties. No build step. Fully custom, built from scratch.

Structure under `assets/css/`:
- `_variables.css`: Design tokens (colors, spacing, typography, layout, effects). Note: some tokens in _variables.css are overridden by main.css; main.css is the authoritative source for the actual site palette.
- `_base.css`: Reset and foundational styles
- `main.css`: Master stylesheet and the ONLY CSS file loaded by the site. Contains all live styles. The atomic files below are reference copies kept in sync manually; they are NOT imported or loaded. Body uses flexbox column layout with `min-height: 100vh` and `.site-main { flex: 1 }` for proper footer positioning. Section padding uses `--spacing-xl` (2rem) for compact vertical rhythm.

Atomic layers:
- `atoms/`: badges, buttons, icons, images, tags
- `molecules/`: nav-link, post-meta, tag-list, category-list, cta-box, tech-stack
- `organisms/`: header, footer, hero, breadcrumbs, page-header, cards (post, project, guide), post-author, post-navigation, related-posts
- `templates/`: post, project, seo-page (page-level layout styles)
- `utilities/`: helper classes

Live design tokens (from main.css, these override _variables.css):
- Primary: #6b5e54 (warm brown); Primary dark: #524840
- Text: #1a1a1a; Text light: #5c5c5c
- Background: #f5f3f0 (cream); Card bg: #ffffff; Alt bg: #faf9f7; Dark bg: #2a2826
- System font stack: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif
- Monospace stack: 'SF Mono', Monaco, 'Cascadia Code', 'Roboto Mono', Consolas, monospace
- Spacing scale: xs (0.25rem) through 3xl (4rem)
- Max width: 1200px; Content width: 720px

## 6. Liquid Component Library

Includes organized under `_includes/` following the same atomic pattern:

atoms/: badge, button, icon, image, meta-item, tag
molecules/: breadcrumb-item, category-list, cta-box, nav-link, post-meta, social-link, tag-list, tech-stack
organisms/: breadcrumbs, footer, guide-card, header, hero, page-header, post-author, post-card, post-navigation, project-card, related-posts

Root-level includes: head.html (favicon, i18n_headers, seo tag, stylesheet, feed meta)

Layouts in `_layouts/`: default.html (base), post.html, project.html, seo_page.html

All components that display user-facing text use `site.data[site.active_lang].strings` for localization. No hardcoded display strings in templates.

## 7. Content Front Matter Reference

See CONTENT_GUIDE.md for full templates and examples. Summary of required fields:

Posts: title (required), description (required), date (required), lang (required: "fi" or "en"). Optional: categories, tags, read_time, image (defaults to /assets/images/og/blog-default.webp), author (defaults to "Admin"), permalink.

Projects: title (required), description (required), date (required), status (required), lang (required: "fi" or "en"). Optional: tagline, tech, live_url, github_url, demo_path, image (defaults to /assets/images/og/projects-default.webp), lessons, results.

SEO Pages: Currently disabled. title (required), description (required), category (required), last_updated (required), keywords (required). Optional: related_pages, cta.

Use `published: false` in front matter to keep any post or project as a draft.

## 8. Deployment

Branch strategy: `staging` for development, `main` triggers GitHub Pages build and deploy.

Build pipeline: Custom GitHub Actions workflow (`.github/workflows/jekyll.yml`) because jekyll-polyglot is not a default GitHub Pages plugin. The workflow installs Ruby, runs `bundle exec jekyll build`, and deploys the built `_site/` to GitHub Pages.

Workflow:
1. Work on staging branch
2. Test locally with `bundle exec jekyll serve`
3. When ready to deploy, merge staging into main
4. GitHub Actions builds and deploys automatically

Local development:
- `bundle install` to install dependencies
- `bundle exec jekyll serve` for local server at localhost:4000
- `bundle exec jekyll serve --livereload` for auto-refresh
- Finnish pages at localhost:4000/, English pages at localhost:4000/en/

## 9. SEO Setup

### Plugins
- jekyll-seo-tag (2.8.0): Generates title, meta description, Open Graph tags, Twitter cards, canonical URLs, and JSON-LD structured data from front matter and _config.yml
- jekyll-feed (0.17.0): Generates RSS feed at /feed.xml
- Note: jekyll-sitemap was removed. A custom `sitemap.xml` template replaces it (see below).

### Sitemap
The site uses a custom `sitemap.xml` Liquid template (not jekyll-sitemap) because jekyll-sitemap does not work correctly with jekyll-polyglot. The plugin sees all pages from both languages and outputs raw permalinks without language prefixes. Polyglot's URL rewriting only processes HTML, not XML, so the English `/en/` prefix never gets added.

The custom sitemap template:
- Is excluded from localization (single sitemap at root, not duplicated per language)
- Iterates all pages, posts, and projects
- Checks each document's `lang` field to determine the correct URL prefix (root for Finnish, `/en/` for English)
- Adds `xhtml:link` hreflang alternates for documents that have a `twin` field
- Skips documents with `sitemap: false` in front matter
- `robots.txt` points to this single sitemap

### Multi-language SEO
- `{{ I18n_Headers }}` in head.html generates hreflang alternate link tags for each language variant
- `<html lang="{{ site.active_lang }}">` in default.html sets the correct language attribute per page
- CreativeWork schema on project pages includes `inLanguage` property from `site.active_lang`

### Meta tags
All meta tags are generated by jekyll-seo-tag via `{% seo %}` in head.html. No manual OG/Twitter/canonical tags in head.html (removed to avoid duplicates). The plugin reads from page front matter and _config.yml.

### Structured data (JSON-LD)
jekyll-seo-tag automatically generates:
- `WebSite` schema on homepage and about page (with `sameAs` links to LinkedIn and GitHub from `social.links` config)
- `BlogPosting` schema on blog posts (with author resolved from `_data/authors.yml`)
- `BlogPosting` schema on project pages (auto-generated by plugin; supplemented by custom CreativeWork)
- `Organization` publisher with logo (when `logo` is configured in _config.yml)

Custom JSON-LD blocks (hand-authored in Liquid):
- `BreadcrumbList` on all pages with breadcrumbs (`_includes/organisms/breadcrumbs.html`). Mirrors the visual breadcrumb trail for posts, projects, seo_pages, and default pages. Labels are localized.
- `CreativeWork` on project pages (`_layouts/project.html`). Captures tech stack as keywords, GitHub URL as isBasedOn, live URL, creativeWorkStatus, inLanguage, and author with sameAs links.
- `ProfilePage` on the about page (`about.html` and `about-fi.html`). Contains Person entity with name, description, jobTitle, knowsAbout, sameAs links, and image (when avatar is configured).

### Author resolution for schema
`_data/authors.yml` maps display names to schema names. When `page.author` is "Admin" (the visual display name), jekyll-seo-tag looks it up in authors.yml and uses the mapped `name: "Esa Hakulinen"` for the BlogPosting schema. This keeps the visual "Written by Admin" / "Kirjoittanut Admin" label while the schema always shows the real author name.

### Default images
Default OG images are set per content type in _config.yml defaults:
- Blog posts: /assets/images/og/blog-default.webp
- Projects: /assets/images/og/projects-default.webp
- Site-wide fallback: /assets/images/og/og-default.webp (set via `og_image` in _config.yml)

Individual posts/projects override with their own `image` field in front matter.

### Config keys used by jekyll-seo-tag
- `title`, `description`, `url`, `lang` (set to `fi`)
- `author` (hash with name, bio, linkedin, github)
- `social.name` and `social.links` (generates sameAs on homepage/about)
- `og_image` (site-wide default OG image)
- Twitter config: currently commented out (no Twitter/X presence)
- Google Analytics: not yet configured (placeholder in _config.yml)

## 10. Favicon

Full favicon set using "eH" monogram (matching the nav logo camelCase style):
- `assets/images/favicon.svg`: SVG for modern browsers (scalable, uses site palette)
- `favicon.ico`: ICO with 16x16 and 32x32 (in repo root for legacy browsers)
- `assets/images/apple-touch-icon.png`: 180x180 for iOS
- `assets/images/android-chrome-192x192.png` and `android-chrome-512x512.png`: for Android/PWA
- `assets/images/favicon-16x16.png` and `favicon-32x32.png`: PNG fallbacks
- `site.webmanifest`: PWA manifest with theme and icons

Colors: dark warm background (#2a2826) with cream text (#f5f3f0), matching the site palette.
Referenced in head.html with proper link tags and theme-color meta.

## 11. Image Handling

All images in `assets/images/`, organized by type:
- `author/`: Author avatars (admin.svg placeholder for "Admin" display name; profile image not yet added)
- `blog/`: Blog post featured images
- `og/`: Open Graph social sharing defaults (og-default.webp, blog-default.webp, projects-default.webp)
- `pages/`: Page-level hero and decorative images (some referenced in front matter but not yet created)
- `projects/`: Project showcase images

Preferred format: .webp
Reference in front matter: `image: /assets/images/blog/filename.webp`
Reference in Markdown: `![Alt text](/assets/images/blog/filename.webp)`

Images are excluded from localization (shared across both language versions).

## 12. Build Exclusions

Excluded from Jekyll builds (configured in _config.yml):
README.md, Gemfile, Gemfile.lock, node_modules, vendor, .git, shell scripts (*.sh), CONTENT_GUIDE.md, CONTEXT.md, .claude, docs

Excluded from localization (shared assets, not duplicated per language):
javascript, images, css, assets, sitemap.xml, favicon.ico, site.webmanifest, CNAME

SEO pages collection set to `output: false` so they are not built or included in sitemap.

## 13. Site Pages and Navigation

Navigation: Koti/Home, Blogi/Blog, Projektit/Projects, Tietoa/About (localized via strings files)
Nav logo: "esaHakulinen" in camelCase, using the site's sans-serif font (font-weight: 600, 1.125rem)
Language switcher: "In English" / "Suomeksi" at far right on desktop, bottom of hamburger menu on mobile

Desktop nav layout: CSS grid with three columns (logo left, nav links centered, lang switcher right)
Mobile nav layout: flex with logo left, hamburger right; nav links and lang switcher in dropdown

Static HTML pages (Liquid templated), each with Finnish and English versions:
- index.html / index-en.html (homepage)
- blog.html / blog-en.html (blog listing)
- projects.html / projects-en.html (projects listing)
- about-fi.html / about.html (about page, includes ProfilePage schema)
- guides.html (exists but not linked from navigation; guides collection disabled)

Standalone projects directory: `projects/` (for React apps, interactive demos)

## 14. Voice & Content

See `docs/VOICE_AND_STYLE.md` for the full voice and style guide, including the **Finnish Language Guidelines** section. Key principles:

- Straightforward, almost blunt. No romanticizing, no poetry, no motivational-poster language.
- Site pages (home, about, projects, blog listing) are neutral and factual. No opinions.
- Blog posts can be opinionated, but opinions are intentional, not casual.
- Design philosophy and deeper thinking belong in project write-ups, not in declarations.
- Describe what you do, not what you are: "I work in digital marketing" not "I am a digital marketer." Finnish: "Työskentelen digitaalisessa markkinoinnissa" not "Olen digitaalinen markkinoija."
- Site is framed as "kotisivu" (personal site), not "portfoliosivusto" (portfolio site).
- Dry humor through stating the obvious. Don't try to be funny.
- No em dashes or en dashes. No exclamation marks. No "journey," "insights," or "passionate about." Finnish equivalent: no "matkan varrella."
- No implicit promises or commitments about what the site will contain.
- Sentence case for all headings, buttons, and labels. Never title case in Finnish.
- Finnish register: deliberately mix casual ("pyörii", "hoitaa homman") with precise ("merkittävästi", "auktoritatiivinen"). Long compound words are fine. Allow longer sentences than English. Use English tech terms as-is with Finnish inflection.
- Footer bio text is localized via `strings.footer_bio`, not from `site.author.bio` in _config.yml.
- Post navigation (previous/next) is language-filtered in `_layouts/post.html`; never use Jekyll's built-in `page.previous`/`page.next`.

See also `CONTENT_GUIDE.md` (references the voice guide).

## 15. Social & Author Config

Author: Esa Hakulinen
Display name (posts): "Admin" (visual label; schema resolves to real name via _data/authors.yml)
LinkedIn: esahakulinen
GitHub: esaHak
Twitter: not configured (commented out in _config.yml)
Email: not configured
Avatar: not configured (commented out; no profile image added yet)
Logo: not configured (commented out; would enable Organization schema when added)

Social links for schema (in _config.yml `social` block):
- https://www.linkedin.com/in/esahakulinen
- https://github.com/esaHak

## 16. Troubleshooting

Build failures: Check YAML front matter validity, Liquid syntax, Jekyll version compatibility, GitHub Actions build logs.

Local server issues: Run `bundle update`, clear cache with `rm -rf .jekyll-cache`, rebuild with `bundle exec jekyll build --verbose`.

Multi-language issues: Ensure every content file has `lang:` in front matter. If a page shows the wrong language content, check that the `lang` value matches the intended language and the file is not missing. Restart the local server after _config.yml changes.

## 17. Known Gotchas

- Never commit _site/ to git (GitHub Pages rebuilds it; .gitignore handles this)
- Clear .jekyll-cache if builds produce stale output
- jekyll-polyglot is not a default GitHub Pages plugin; the site uses a custom GitHub Actions workflow for deployment (`.github/workflows/jekyll.yml`)
- Every content file (post, project, page) must have `lang: fi` or `lang: en` in front matter; missing this causes the content to appear in both language builds or only in the default language
- When adding new UI text to templates, add the key to both `_data/fi/strings.yml` and `_data/en/strings.yml`; never hardcode display text
- Front matter must be valid YAML; a missing closing `---` breaks the entire build
- CNAME file must stay in repo root for custom domain to work
- _config.yml changes require restarting the local Jekyll server (unlike content edits which hot-reload)
- .blog-list .container uses CSS grid; any new wrapper class inside it needs `grid-column: 1 / -1` to span full width (see .mt-1 fix)
- The post-author component supports per-post author overrides via front matter; non-default authors get the admin.svg placeholder avatar
- SEO pages collection exists in the repo but is disabled (output: false); re-enable in _config.yml when ready
- _variables.css and main.css both define CSS custom properties; main.css overrides are the live values. When changing colors or tokens, edit main.css (the authoritative file).
- head.html captures `{% seo %}` output and patches it for English pages (canonical/og:url fix). Do not add manual OG/Twitter/canonical meta tags outside this capture/replace block; jekyll-seo-tag handles all of these.
- The `social.links` config only generates `sameAs` in JSON-LD on the homepage and about page (jekyll-seo-tag checks `homepage_or_about?`)
- jekyll-seo-tag assigns schema type by: `page.seo.type` override first, then WebSite for homepage/about, BlogPosting for dated content, WebPage for everything else
- Author "Admin" in post front matter resolves to "Esa Hakulinen" in schema via _data/authors.yml lookup
- Some page-level images referenced in front matter (about.jpg, home.jpg) do not exist yet as files; they only affect OG sharing, not page rendering
- `sass: sourcemap: never` is required in _config.yml for Jekyll 4 + polyglot compatibility
- jekyll-feed + parallel_localization can conflict in CI; disable `parallel_localization` if build errors occur in GitHub Actions
- The language switcher uses `page.twin` field first, then falls back to URL prefix manipulation; all new content must have a `twin` field because Finnish and English URLs use different slugs
- Polyglot post-processes rendered HTML and rewrites ALL relative `href` and `src` attributes to add the language prefix for non-default languages; use `{% static_href %}href="..."{% endstatic_href %}` to prevent rewriting specific links (used in language switcher)
- `{{ I18n_Headers }}` was replaced by custom hreflang logic in head.html. The polyglot tag does not work with localized URL slugs (it cannot pair pages by permalink). Custom Liquid in head.html reads the `twin` field to generate correct hreflang link tags.
- The `{% seo %}` tag output is captured and string-replaced in head.html to fix English canonical/og:url (polyglot rewrites relative URLs in HTML but not absolute URLs from `absolute_url`). Side effect: og:image URLs on English pages get `/en/` prefix; GitHub Pages serves images from both paths so this is harmless but could be refined later.
- Dates use localized month names via `_includes/atoms/localized-date.html`. Month names are stored as `month_1` through `month_12` in both string files. Do NOT use Jekyll's `date: "%B"` filter for user-facing dates; it always outputs English.
- The `_config.yml` default `permalink: /blog/:title/` applies to the default language (Finnish), giving Finnish posts English URL prefixes; every blog post must override with an explicit permalink
- Content listing pages (blog.html, projects.html, etc.) must filter by `| where: "lang", site.active_lang` to avoid showing both language versions in listings
- CLAUDE.md files inside `_posts/` or `_projects/` directories will be processed as content unless excluded; add them to _config.yml exclude list
- Do NOT use jekyll-sitemap with jekyll-polyglot. The plugin iterates all pages (both languages) and outputs raw permalinks. Polyglot's URL rewriting only processes HTML, not XML, so English URLs never get the `/en/` prefix. Use the custom `sitemap.xml` Liquid template instead.
- Liquid variable names cannot start with a number. Keys like `404_title` in string data files cause "Expected id but found number" syntax errors. Use names like `error_title` instead.
- Jekyll's built-in `page.previous` and `page.next` iterate through ALL posts regardless of language. The `_layouts/post.html` now filters by `page.lang` manually to find same-language previous/next posts. Do NOT revert to using `page.previous`/`page.next` directly.
- The footer bio text is localized via `strings.footer_bio` in the string data files, NOT from `site.author.bio` in _config.yml. The _config.yml bio is English-only and used by jekyll-seo-tag for schema output. Do not use `site.author.bio` for visible UI text.

### Footer positioning and vertical spacing

The body uses `display: flex; flex-direction: column; min-height: 100vh` with `.site-main { flex: 1 }`. This keeps the footer at the bottom of the viewport on short pages without adding unnecessary whitespace. A previous approach used `min-height: calc(100vh - 200px)` on `.site-main`, which pushed the footer far down on pages with little content (blog, projects, about). Do not reintroduce fixed min-height on `.site-main`.

Section padding was reduced from `--spacing-3xl` (4rem) to `--spacing-xl` (2rem) because consecutive sections were creating 128px gaps. Hero, headers, content blocks, and footer all use similarly compact padding. If pages look too spread out, check that section padding has not been reverted.

### Project cards show year

Project cards (both the `organisms/project-card.html` include and the inline cards on the homepage) display the project year (from `date` front matter) alongside the status badge in a flex row (`.project-card-meta-row`). The homepage project cards use the `atoms/badge.html` include for status badges instead of hardcoded badge logic.

### Git lock file issues in Cowork / mounted filesystem environments

When working on this repo through Cowork (or any environment where the repo is on a mounted filesystem), git operations can leave behind `.git/HEAD.lock` and `.git/index.lock` files that the filesystem refuses to delete. This blocks all subsequent git commands with "Another git process seems to be running" errors.

Symptoms: `rm` fails with "Operation not permitted" even though the user owns the file. The issue is at the filesystem/mount level, not a permissions problem.

Workaround that works:
1. Clone the repo to a local (non-mounted) path: `git clone /path/to/mounted/repo /tmp/repo-temp`
2. Copy the working tree into the clone: `rsync -a --exclude='.git' --exclude='_site' --exclude='.jekyll-cache' /path/to/mounted/repo/ /tmp/repo-temp/`
3. Set git identity in the clone: `git config user.name` / `git config user.email` (copy values from the original repo's config)
4. Make all commits in `/tmp/repo-temp` (lock files can be cleaned up normally on a local filesystem)
5. Push to a temporary branch in the original repo: `git push origin branch:refs/heads/branch-temp` (pushing directly to the checked-out branch is denied by default)
6. In the original repo, update the branch ref manually: `echo "<commit-hash>" > .git/refs/heads/<branch>`
7. Copy the clean index from the temp clone: `cp /tmp/repo-temp/.git/index .git/index`
8. Verify with `git status` (should show clean working tree)

Things that do NOT work: `rm`, `mv`, `unlink()` via Python/Perl, or `truncate` followed by `rm`. Truncating the lock file to zero bytes does not help because git checks for file existence, not content.

If git is only partially stuck (lock file exists but git add/status still works), you can sometimes recover by truncating the lock file with `: > .git/HEAD.lock` and then proceeding. But this is unreliable.

### Jekyll build not possible in Cowork environment

The Cowork VM has Ruby and Gem installed (`/usr/bin/ruby`, `/usr/bin/gem`) but lacks `ruby-dev` and `build-essential`, which are needed to compile native gem extensions (e.g., the `json` gem required by Jekyll). There is no `sudo` access, so these system packages cannot be installed.

What happens every time:
1. `bundle` is not found (not pre-installed)
2. Install bundler with `gem install --user-install bundler` (this works)
3. `bundle install` fails on native extensions (json, ffi, etc.) because `ruby-dev` headers are missing
4. `sudo apt-get install ruby-dev build-essential` fails ("no new privileges" flag)

Do NOT waste time trying to get `bundle exec jekyll build` or `bundle exec jekyll serve` working in Cowork. It will fail every time.

Instead, validate changes by:
- Checking Liquid syntax manually (matching `{% %}` and `{{ }}` tags, valid YAML front matter)
- Using a subagent to read and verify all modified templates
- Asking the user to run `bundle exec jekyll serve` locally on their machine before committing

The local build test must happen on the user's actual computer, not in the Cowork VM.

## 18. Future Directions

Outstanding items identified during audits. None of these are blocking; the site works correctly without them.

### Missing OG images for structural pages

The homepage and about page reference default OG images (`og-default.webp`) but no page-specific OG images exist for them. Social sharing previews fall back to the default image. Creating dedicated `home.jpg` and `about.jpg` in `assets/images/og/` would improve link previews on social platforms.

### Google Analytics

The `google_analytics` field in `_config.yml` is empty. Add a GA4 measurement ID when analytics tracking is needed.

### RSS feed language filtering

Both the Finnish and English RSS feeds (generated by `jekyll-feed`) contain posts from both languages. This is a known compatibility issue between `jekyll-feed` and `jekyll-polyglot`. The plugin does not filter by `page.lang`. Fixing this would require either a custom feed template (similar to the custom sitemap approach) or post-processing the feed output.

### Lighthouse / performance audit

Initial checks on the live site showed good fundamentals (system fonts, minimal JS, no render-blocking resources). A formal Lighthouse audit has not been completed. Running one from Chrome DevTools would establish baseline scores for Performance, Accessibility, Best Practices, and SEO.

### Content expansion

The site currently has minimal content (one blog post, one project page). Adding more posts and projects is the main content priority. The infrastructure supports it; the bottleneck is writing.
