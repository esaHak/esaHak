---
name: css-design-system
description: Activate when working on styling, CSS, components, design tokens, or
  the atomic design system. Triggers on "style", "CSS", "design", "component",
  "color", "spacing", "layout", "responsive", or visual changes.
---

# CSS Design System: Project Context

## Before Starting

1. Read CONTEXT.md Section 4 for the atomic CSS structure and design tokens
2. Read assets/css/_variables.css for current design tokens
3. Read docs/design/ for design decisions from previous sessions
4. Read assets/css/CLAUDE.md for CSS conventions

## Project-Specific Context

- CSS is organized in atomic layers under assets/css/: atoms/, molecules/, organisms/, templates/, utilities/
- Design tokens live in assets/css/_variables.css as CSS custom properties
- main.css is the master stylesheet that imports all modular files
- No CSS preprocessors; plain CSS only
- Liquid includes in _includes/ mirror the same atomic structure
- Base styles and reset are in _base.css

## After Completing Work

1. Update docs/design/ with design decisions or token changes
2. Update assets/css/CLAUDE.md if new CSS patterns were established
3. Update CONTEXT.md Section 4 if the design system structure changed
