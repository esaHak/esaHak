---
title: "Portfolio Website"
description: "This very site - a Jekyll-based portfolio with blog, projects, and programmatic SEO capabilities."
image: /assets/images/projects/portfolio-website.jpg
date: 2025-01-20
status: live
tagline: "A flexible foundation for sharing my work online"
tech:
  - Jekyll
  - GitHub Pages
  - Markdown
  - CSS
live_url: "https://esahakulinen.fi"
lessons:
  - "Jekyll's collections system is powerful for organizing different content types"
  - "GitHub Pages provides free, reliable hosting with automatic deployments"
  - "Starting simple and iterating is better than trying to build everything at once"
results:
  - value: "1"
    label: "Day to Launch"
  - value: "100%"
    label: "Uptime"
  - value: "Free"
    label: "Hosting Cost"
---

## The Challenge

I needed a personal website that could:
- Showcase my projects and experiments
- Host a blog for sharing insights
- Support programmatic SEO experiments
- Be easy to update without complex deployment processes

## The Solution

After evaluating several options (WordPress, custom React app, Webflow), I chose Jekyll with GitHub Pages because:

1. **Simplicity**: Write in Markdown, push to GitHub, done
2. **Flexibility**: Can embed React apps or any other tech as needed
3. **Cost**: Free hosting with GitHub Pages
4. **SEO**: Static sites are fast and SEO-friendly out of the box
5. **Version Control**: Everything is tracked in Git

## Technical Details

The site uses Jekyll's collections feature to organize content:

- `_posts/` for blog articles
- `_projects/` for project showcases
- `_seo_pages/` for programmatic SEO content

Each content type has its own layout template, making it easy to maintain consistency while allowing customization.

## What I Learned

Building this site reinforced some important principles:

1. **Start with the simplest solution** that could work
2. **Optimize for content creation**, not just initial design
3. **Plan for future expansion** but don't over-engineer upfront

## Next Steps

- Add more projects and case studies
- Implement programmatic SEO experiments
- Consider adding a newsletter signup
- Explore embedding interactive React demos
