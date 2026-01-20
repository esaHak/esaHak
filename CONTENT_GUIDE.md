# Content Guide for esahakulinen.fi

This guide explains how to add and manage content on your portfolio site.

## Table of Contents

1. [Quick Start](#quick-start)
2. [Adding Blog Posts](#adding-blog-posts)
3. [Adding Projects](#adding-projects)
4. [Adding SEO/Guide Pages](#adding-seoguide-pages)
5. [Adding Standalone Projects (React, etc.)](#adding-standalone-projects)
6. [Customizing the Site](#customizing-the-site)
7. [Common Tasks](#common-tasks)

---

## Quick Start

Your site uses Jekyll with GitHub Pages. The basic workflow is:

1. Create/edit a Markdown file in the appropriate folder
2. Commit and push to GitHub
3. GitHub Pages automatically builds and deploys your site

**No local setup required!** Just edit files and push.

---

## Adding Blog Posts

### Location
`_posts/`

### File Naming
Files MUST follow this format: `YYYY-MM-DD-title-slug.md`

Example: `2025-01-20-my-first-post.md`

### Template

```markdown
---
title: "Your Post Title"
description: "A brief description for SEO and previews (1-2 sentences)"
date: 2025-01-20
categories: [Category Name]
tags: [tag1, tag2, tag3]
read_time: 5
image: /assets/images/post-image.jpg  # Optional
---

Your content goes here in Markdown format.

## Section Heading

Regular paragraphs, **bold text**, *italic text*.

### Subsection

- Bullet points
- Work like this

1. Numbered lists
2. Work like this

> Blockquotes look like this

```code
Code blocks work too
```
```

### Front Matter Options

| Field | Required | Description |
|-------|----------|-------------|
| `title` | Yes | Post title |
| `description` | Yes | SEO description (< 160 chars) |
| `date` | Yes | Publication date (YYYY-MM-DD) |
| `categories` | No | Single category in array format |
| `tags` | No | Multiple tags for organization |
| `read_time` | No | Estimated minutes to read |
| `image` | No | Featured image path |
| `author` | No | Override default author |

---

## Adding Projects

### Location
`_projects/`

### File Naming
Use a descriptive slug: `project-name.md`

Example: `seo-tool-experiment.md`

### Template

```markdown
---
title: "Project Name"
description: "Brief project description"
date: 2025-01-20
status: in-progress  # Options: live, in-progress, experiment, archived
tagline: "A catchy one-liner"
tech:
  - Technology 1
  - Technology 2
  - Technology 3
live_url: "https://example.com"  # Optional
github_url: "https://github.com/..."  # Optional
demo_path: "/projects/demo-name/"  # Optional - for embedded demos
image: /assets/images/project-screenshot.jpg  # Optional
lessons:
  - "Key learning 1"
  - "Key learning 2"
results:  # Optional metrics
  - value: "50%"
    label: "Improvement"
  - value: "1000"
    label: "Users"
---

## The Challenge

Describe the problem you were solving.

## The Solution

Explain your approach.

## Technical Details

Any technical information worth sharing.

## What I Learned

Insights from the project.

## Next Steps

Future plans for this project.
```

### Status Options

- `live` - Project is deployed and active (green badge)
- `in-progress` - Currently being worked on (blue badge)
- `experiment` - Testing an idea (yellow badge)
- `archived` - No longer maintained (gray badge)

---

## Adding SEO/Guide Pages

### Location
`_seo_pages/`

These are perfect for programmatic SEO content—comprehensive guides targeting specific keywords.

### File Naming
Use the target keyword slug: `keyword-phrase-guide.md`

### Template

```markdown
---
title: "Complete Guide to [Topic]"
description: "Comprehensive description targeting your keyword (< 160 chars)"
category: Category Name
last_updated: 2025-01-20
keywords:
  - primary keyword
  - secondary keyword
  - related term
related_pages:
  - other-guide-slug
cta:
  title: "Call to Action Title"
  description: "Why they should take action"
  url: "/target-page/"
  button: "Button Text"
---

Introduction paragraph with your primary keyword naturally included.

## Main Section 1

Content covering the topic thoroughly.

## Main Section 2

More valuable content.

## Conclusion

Wrap up and reinforce key points.
```

### Scaling SEO Pages

For programmatic SEO at scale:

1. Define your topic template in `_data/seo_topics.yml`
2. Create corresponding pages in `_seo_pages/`
3. Or generate pages programmatically from data

The data file lets you manage topics centrally and could be extended to auto-generate pages.

---

## Adding Standalone Projects

For React apps, interactive demos, or other complex projects:

### Location
`projects/[project-name]/`

### Setup

1. Create a folder: `projects/my-react-app/`
2. Build your project (React, Vue, etc.)
3. Place the built files in the folder
4. Access at: `https://esahakulinen.fi/projects/my-react-app/`

### Example: React App

```bash
# In your React project
npm run build

# Copy build files to your portfolio
cp -r build/* /path/to/esaHak/projects/my-react-app/
```

### Linking from Project Pages

In your project markdown file:

```yaml
demo_path: "/projects/my-react-app/"
```

This adds an "Interactive Demo" button on the project page.

---

## Customizing the Site

### Site Settings
Edit `_config.yml` to change:
- Site title and description
- Author information
- Social media links
- SEO settings

### Styling
Edit `assets/css/main.css` to customize:
- Colors (CSS variables at top)
- Fonts
- Spacing
- Component styles

### Navigation
Edit `_includes/nav.html` to add/remove menu items.

### Layouts
Edit files in `_layouts/` to change page structures:
- `default.html` - Base template
- `post.html` - Blog post template
- `project.html` - Project page template
- `seo_page.html` - Guide/SEO page template

---

## Common Tasks

### Adding Images

1. Place images in `assets/images/`
2. Reference them in Markdown:

```markdown
![Alt text](/assets/images/your-image.jpg)
```

Or in front matter:
```yaml
image: /assets/images/your-image.jpg
```

### Creating a New Category/Section

1. Create a new collection in `_config.yml`:

```yaml
collections:
  new_section:
    output: true
    permalink: /new-section/:name/
```

2. Create folder `_new_section/`
3. Create layout `_layouts/new_section.html`
4. Create index page `new-section.html`

### Updating Social Links

Edit `_config.yml`:

```yaml
author:
  twitter: "your_handle"
  linkedin: "your-profile"
  github: "your-username"
```

### Adding Google Analytics

1. Get your GA tracking ID
2. Add to `_config.yml`:

```yaml
google_analytics: "G-XXXXXXXXXX"
```

---

## File Structure Reference

```
esaHak/
├── _config.yml          # Site configuration
├── _data/               # Data files (YAML, JSON)
│   └── seo_topics.yml   # SEO topics data
├── _includes/           # Reusable HTML components
│   ├── head.html
│   ├── nav.html
│   └── footer.html
├── _layouts/            # Page templates
│   ├── default.html
│   ├── post.html
│   ├── project.html
│   └── seo_page.html
├── _posts/              # Blog posts (YYYY-MM-DD-title.md)
├── _projects/           # Project showcases
├── _seo_pages/          # SEO/Guide content
├── assets/
│   ├── css/main.css     # Styles
│   ├── js/main.js       # JavaScript
│   └── images/          # Image files
├── projects/            # Standalone project builds
├── index.html           # Homepage
├── blog.html            # Blog listing
├── projects.html        # Projects listing
├── guides.html          # Guides listing
├── about.html           # About page
├── CNAME                # Custom domain
└── Gemfile              # Ruby dependencies
```

---

## Need Help?

- [Jekyll Documentation](https://jekyllrb.com/docs/)
- [Markdown Guide](https://www.markdownguide.org/)
- [GitHub Pages Documentation](https://docs.github.com/en/pages)

Happy building! 🚀
