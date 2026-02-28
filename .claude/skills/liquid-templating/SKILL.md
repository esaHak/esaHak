---
name: liquid-templating
description: Activate when working on Liquid templates, layouts, includes, or
  front matter logic. Triggers on "layout", "template", "include", "Liquid",
  "front matter", "partial", "component" (in the context of HTML/templating).
---

# Liquid Templating: Project Context

## Before Starting

1. Read CONTEXT.md Section 5 for the component library structure
2. Read _includes/CLAUDE.md for include conventions
3. Read _layouts/CLAUDE.md for layout conventions
4. Review existing includes in the target atomic level (atoms/, molecules/, organisms/)

## Project-Specific Context

- Includes are organized under _includes/: atoms/, molecules/, organisms/
- Root-level includes (head.html, nav.html, footer.html) are shared across all layouts
- Four layouts in _layouts/: default (base), post, project, seo_page
- Each Liquid include has a corresponding CSS file in assets/css/ at the same atomic level
- Layouts use Liquid layout inheritance from default.html

## After Completing Work

1. Update _includes/CLAUDE.md if new include patterns were established
2. Update _layouts/CLAUDE.md if layout structure changed
3. Update CONTEXT.md Section 5 if the component library grew or changed
