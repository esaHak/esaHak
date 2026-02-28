---
name: jekyll-content
description: Activate when adding or editing blog posts, projects, or SEO guide pages.
  Triggers on "new post", "add project", "write guide", "create content", "blog",
  "article", or any content creation task.
---

# Jekyll Content: Project Context

## Before Starting

1. Read CONTEXT.md Sections 3 and 6 for collection structure and front matter requirements
2. Read CONTENT_GUIDE.md for detailed templates and examples
3. Read docs/content-patterns/ for conventions established by previous sessions
4. Check existing content in the target collection for naming and style consistency

## Project-Specific Context

- Blog posts go in _posts/ with filename format YYYY-MM-DD-title-slug.md
- Projects go in _projects/ with descriptive slug filenames
- SEO pages go in _seo_pages/ with keyword-based slugs
- Required front matter fields are documented in CONTEXT.md Section 6
- Featured images go in assets/images/ under the matching subdirectory (blog/, projects/)
- Preferred image format: .webp

## After Completing Work

1. Update docs/content-patterns/ with any new conventions or patterns used
2. Update CONTEXT.md Section 6 if new front matter fields were introduced
3. Update the relevant subdirectory CLAUDE.md (_posts/, _projects/) if patterns changed
