# CLAUDE.MD

## Project Overview

Personal portfolio and blog site for Esa Hakulinen, built with Jekyll and hosted on GitHub Pages. The site showcases digital marketing expertise, projects, and insights.

**Live Site:** https://esahakulinen.fi

## Technology Stack

- **Static Site Generator:** Jekyll
- **Hosting:** GitHub Pages
- **Templating:** Liquid
- **Styling:** Custom CSS (assets/css/)
- **Plugins:** jekyll-feed, jekyll-seo-tag, jekyll-sitemap

## Project Structure

```
esaHak/
├── _config.yml           # Jekyll configuration
├── _includes/            # Reusable components (header, footer, etc.)
├── _layouts/             # Page templates (default, post, project, seo_page)
├── _posts/              # Blog articles (Markdown)
├── _projects/           # Project showcases
├── _seo_pages/          # Programmatic SEO / Guide content
├── _site/               # Generated static site (not in version control)
├── assets/              # CSS, JavaScript, and images
├── projects/            # Standalone interactive projects (React apps, demos)
├── index.html           # Homepage
├── blog.html            # Blog listing page
├── projects.html        # Projects listing page
├── guides.html          # Guides listing page
├── about.html           # About page
├── CONTENT_GUIDE.md     # Content creation instructions
└── README.md            # Quick reference
```

## Key Features

### Collections

Three Jekyll collections are configured:

1. **Projects** (`_projects/`)
   - Permalink: `/projects/:name/`
   - Layout: `project`
   - Showcases portfolio work

2. **SEO Pages** (`_seo_pages/`)
   - Permalink: `/guides/:path/`
   - Layout: `seo_page`
   - Programmatic SEO content and guides

3. **Posts** (`_posts/`)
   - Permalink: `/blog/:title/`
   - Layout: `post`
   - Blog articles

### Recent Additions

- Breadcrumbs feature (commit: bc46af7)
- Jekyll site base infrastructure (commit: 2cbaf26)

## Development Workflow

### Local Development

```bash
bundle install          # Install dependencies
bundle exec jekyll serve  # Run local server at http://localhost:4000
```

### Deployment

The site automatically builds and deploys when changes are pushed to GitHub:

1. Edit files in the appropriate folder
2. Commit and push to `main` branch
3. GitHub Pages automatically builds and deploys

**Current Branch:** staging
**Main Branch:** main

### Git Status Notes

Modified files awaiting commit:
- CSS files (main.css)
- Generated site files (_site/)
- New image includes and assets

Untracked:
- .DS_Store
- _includes/image.html
- assets/images/

## Content Management

For detailed content creation instructions, see [CONTENT_GUIDE.md](CONTENT_GUIDE.md).

### Quick Content Guide

**Blog Posts:** Create in `_posts/` with format `YYYY-MM-DD-title.md`

**Projects:** Create in `_projects/` with front matter including title, description, image, etc.

**SEO Pages/Guides:** Create in `_seo_pages/` for programmatic content

## Configuration

Key configuration in `_config.yml`:

- **Site title:** "Esa Hakulinen"
- **Description:** "Digital marketing expertise, experiments, and insights. Building in public."
- **Permalink structure:** `/blog/:title/`
- **Collections:** projects, seo_pages

## SEO & Analytics

- Jekyll SEO Tag plugin for meta tags
- Sitemap automatically generated
- RSS feed via jekyll-feed
- Google Analytics ID: (to be configured)
- Open Graph image: `/assets/images/og-default.png`

## Important Notes

### For Claude Code

- **Never commit** generated `_site/` files (these are built by GitHub Pages)
- **CSS changes** should be made in `assets/css/`, not in `_site/`
- **New content** should follow the patterns in CONTENT_GUIDE.md
- **Images** should be placed in `assets/images/`
- **Test locally** before pushing with `bundle exec jekyll serve`

### File Exclusions

The following are excluded from builds (see `_config.yml`):
- README.md
- Gemfile files
- node_modules
- CONTENT_GUIDE.md
- .git directory
- Shell scripts

## Common Tasks

### Adding a Blog Post

1. Create file in `_posts/` named `YYYY-MM-DD-title.md`
2. Add front matter (title, date, categories, excerpt)
3. Write content in Markdown
4. Commit and push

### Adding a Project

1. Create file in `_projects/` (e.g., `project-name.md`)
2. Add front matter (title, description, image, tech_stack, etc.)
3. Write project description
4. Commit and push

### Adding a Guide

1. Create file in `_seo_pages/` with descriptive filename
2. Add front matter (title, description, keywords)
3. Write guide content
4. Commit and push

### Updating Styles

1. Edit `assets/css/main.css`
2. Test locally with `bundle exec jekyll serve`
3. Commit and push

## Troubleshooting

### Build Failures

- Check Jekyll version compatibility
- Verify all front matter is valid YAML
- Ensure no invalid Liquid syntax
- Check GitHub Pages build logs

### Local Server Issues

- Run `bundle update` to update dependencies
- Clear Jekyll cache: `rm -rf .jekyll-cache`
- Rebuild: `bundle exec jekyll build --verbose`

## Resources

- [Jekyll Documentation](https://jekyllrb.com/docs/)
- [GitHub Pages Documentation](https://docs.github.com/en/pages)
- [Liquid Template Language](https://shopify.github.io/liquid/)
- Site Content Guide: CONTENT_GUIDE.md

## License

Personal project. All rights reserved.
