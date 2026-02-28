---
name: seo-and-metadata
description: Activate when working on SEO, meta tags, Open Graph, Twitter cards,
  schema markup, sitemaps, or keyword optimization. Triggers on "SEO", "meta",
  "Open Graph", "og:", "Twitter card", "schema", "sitemap", "keywords",
  "search engine".
---

# SEO and Metadata: Project Context

## Before Starting

1. Read CONTEXT.md Section 8 for SEO plugin setup and configuration
2. Read docs/seo/ for findings from previous SEO sessions
3. Check _includes/head.html for current meta tag implementation

## Project-Specific Context

- jekyll-seo-tag plugin handles meta tags from front matter
- jekyll-sitemap generates sitemap.xml automatically
- jekyll-feed generates RSS at /feed.xml
- Default OG image: /assets/images/og-default.png (overridable per page via image front matter)
- SEO pages in _seo_pages/ have a keywords array in front matter
- Google Analytics: not yet configured (placeholder in _config.yml)
- Twitter card type: summary_large_image

## After Completing Work

1. Update docs/seo/ with audit findings or new patterns
2. Update CONTEXT.md Section 8 if SEO configuration changed
