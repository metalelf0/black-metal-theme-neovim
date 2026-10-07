# 01: Light theme distinctness and contrast gate
**What to build:** one headless command that loads all 16 light palettes (base and alt), prints pairwise ΔE and WCAG contrast tables, and exits non-zero when any pair is below threshold or any contrast is below minimum. Darkthrone exempt from tinting but included in pairs.
**Blocked by:** None (can start immediately)
**Status:** ready-for-agent
- [ ] Reports closest pairs for base and alt
- [ ] Non-zero exit on failure
- [ ] Runs on current palettes and reports the baseline
