Run a design system consistency audit. Delegate to the design-reviewer agent.

The agent should:
1. Check all CSS files for hardcoded values that should use _variables.css tokens
2. Verify atomic design organization (atoms, molecules, organisms, templates)
3. Confirm each Liquid include in _includes/ has a matching CSS file
4. Review color contrast for accessibility
5. Check responsive patterns for consistency

Save results to docs/design/review-log.md.
