---
title: "Portfolio Website"
description: "This site. Jekyll, GitHub Pages, built with Claude Code."
image: /assets/images/projects/esahakulinen-mixtape-cassette.webp
date: 2025-01-20
status: live
tagline: "esahakulinen.fi"
tech:
  - Jekyll
  - jekyll-polyglot
  - GitHub Pages
  - Claude Code
  - Markdown
  - CSS
live_url: "https://esahakulinen.fi"
permalink: /projects/portfolio-website/
twin: /projektit/portfoliosivusto/
lang: en
results:
  - value: "Free"
    label: "Hosting cost"
  - value: "Live"
    label: "Portfolio site"
---

## Background

The GitHub repository has been around since 2022. It started as a place to test things out and learn. In January 2025, I put together a basic HTML page: a Finnish-language homepage that said "Tervetuloa" and not much else. It ran on a simple `index.html` with some CSS and JavaScript.

A year later, I decided to turn it into a proper portfolio site. I used Claude Code to rebuild the whole thing as a Jekyll project. The base infrastructure, content collections, layouts, and an atomic design system went in over a couple of days.

## Why build it from scratch

There are plenty of existing ways to set up a portfolio site. Templates, themes, website builders. I wanted to build this one from scratch as a practice of creating something fully custom. The design system, layouts, and components are all built by me.

That said, I didn't reinvent everything. The site uses standard Jekyll plugins for the basics, and the custom work sits on top of that.

## Technology choices

**Jekyll** because everything is Markdown files in a Git repository. Write a file, push it, and the site builds automatically. No database, no CMS to maintain.

**GitHub Pages** for hosting. Free, reliable, and the deployment is just a push to the main branch.

**Atomic design structure** for the CSS and templates. The site uses atoms, molecules, and organisms as building blocks. This means adding a new page type or component doesn't require touching existing code.

**jekyll-polyglot** for multi-language support. The site is bilingual from the ground up, and polyglot handles building the site twice (once per language) and routing each version to the correct URL path. Finnish gets the root URLs with Finnish slugs; English gets `/en/` with English slugs. Every template pulls its text from language-specific data files, so adding a language is a data change, not a template rewrite.

**Claude Code** for the actual building. The entire Jekyll infrastructure, all the layouts, includes, and CSS files were built using AI coding tools. This is also how I continue to develop the site.

## SEO setup

The site uses three Jekyll plugins for SEO:

**jekyll-seo-tag** generates meta tags, Open Graph tags, Twitter cards, canonical URLs, and JSON-LD structured data automatically from front matter. The head template contains only `{% raw %}{% seo %}{% endraw %}` instead of manual meta tags, which avoids the common problem of duplicate tags.

**jekyll-sitemap** generates the XML sitemap. **jekyll-feed** handles the RSS feed.

On top of the plugin output, the site has custom JSON-LD schema blocks for specific page types. Project pages get `CreativeWork` schema that captures the tech stack, GitHub URL, and project status. The about page gets `ProfilePage` schema with structured person data. All pages with breadcrumbs get `BreadcrumbList` schema that mirrors the visual breadcrumb navigation.

The author setup uses a split approach. On the page, blog posts are credited to "Admin." An author byline on a portfolio site felt like unnecessary repetition; my name is already in the URL, the navigation, and the about page. Most blog posts on the internet are authored by admin anyway. It fits. Behind the scenes, the structured data resolves to the real author name through a `_data/authors.yml` lookup, so search engines get the right person even if the page doesn't make a fuss about it.

Default OG images are set per content type so every page has something to show when shared, even without a custom image in front matter.

## Multi-language

The site is bilingual: Finnish and English. Finnish is the default language, served at root URLs with Finnish slugs (`/blogi/`, `/projektit/`, `/tietoa/`). English lives under `/en/` with English slugs (`/en/blog/`, `/en/projects/`, `/en/about/`).

This is handled by jekyll-polyglot. Every content file carries a `lang` field in its front matter, and polyglot builds the site twice, once per language, placing each version at the correct URL path. All user-facing text in templates (navigation, buttons, labels, breadcrumbs) comes from language-specific data files rather than being written directly into the HTML. Adding a new string means adding it to both `_data/fi/strings.yml` and `_data/en/strings.yml`.

The localized URL slugs created an interesting problem. Polyglot normally pairs translations by matching their permalinks, but Finnish `/blogi/tervetuloa/` and English `/blog/welcome/` don't match. The solution: a `twin` field in each content file's front matter that points to the other language version's URL. The language switcher reads this field to build the cross-language link.

Another polyglot behavior worth knowing: it post-processes all rendered HTML and rewrites relative URLs to add the language prefix for non-default languages. This breaks the language switcher, because the Finnish URL gets rewritten to include `/en/`. The fix is polyglot's own `{% raw %}{% static_href %}{% endraw %}` tag, which tells it to leave a specific link alone.

The language switcher in the navigation shows "In English" on Finnish pages and "Suomeksi" on English pages. One link, one click. No dropdown, no flags.

Since polyglot isn't a default GitHub Pages plugin, the site uses a custom GitHub Actions workflow for deployment instead of the standard Pages build.

## Content structure

The site has two content types right now: blog posts and project pages. Blog posts are Markdown files in `_posts/`. Project pages (like this one) are in `_projects/`. Each collection has its own layout template. Each content file exists in both Finnish and English, with the language version indicated by `lang` in front matter.

There's room for more content types later. Jekyll's collections system makes that straightforward to add when the time comes.

## Design decisions

The design is deliberately minimal. I didn't want a strong visual direction that would box the site into one style. The idea is that this should work as a platform: something that can hold whatever type of content or project I want to do next, without the design getting in the way. That's why it leans heavily on clean typography, open space, and not much else.

The site uses a warm, editorial palette: earthy browns, cream backgrounds, and a system sans-serif font stack. No web fonts to load. The design tokens live in CSS custom properties, and the master stylesheet (`main.css`) is the authoritative source for the live values.

The navigation logo is "esaHakulinen" in camelCase, using the same font as the rest of the site. The favicon follows the same idea: an "eH" monogram on a dark background, generated as SVG (for modern browsers), ICO (for legacy), and PNG (for iOS and Android).

A portfolio site that's easy to update gets updated. One that's complex to maintain doesn't. So the whole thing is built to stay out of its own way.

## What's next

More projects and blog posts as they come together. The site itself will keep evolving as I use it.
