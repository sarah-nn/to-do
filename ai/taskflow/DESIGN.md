---
name: TaskFlow
colors:
  surface: '#f8f9ff'
  surface-dim: '#cbdbf5'
  surface-bright: '#f8f9ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#eff4ff'
  surface-container: '#e5eeff'
  surface-container-high: '#dce9ff'
  surface-container-highest: '#d3e4fe'
  on-surface: '#0b1c30'
  on-surface-variant: '#464555'
  inverse-surface: '#213145'
  inverse-on-surface: '#eaf1ff'
  outline: '#777587'
  outline-variant: '#c7c4d8'
  surface-tint: '#4d44e3'
  primary: '#3525cd'
  on-primary: '#ffffff'
  primary-container: '#4f46e5'
  on-primary-container: '#dad7ff'
  inverse-primary: '#c3c0ff'
  secondary: '#4648d4'
  on-secondary: '#ffffff'
  secondary-container: '#6063ee'
  on-secondary-container: '#fffbff'
  tertiary: '#005338'
  on-tertiary: '#ffffff'
  tertiary-container: '#006e4b'
  on-tertiary-container: '#67f4b7'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#e2dfff'
  primary-fixed-dim: '#c3c0ff'
  on-primary-fixed: '#0f0069'
  on-primary-fixed-variant: '#3323cc'
  secondary-fixed: '#e1e0ff'
  secondary-fixed-dim: '#c0c1ff'
  on-secondary-fixed: '#07006c'
  on-secondary-fixed-variant: '#2f2ebe'
  tertiary-fixed: '#6ffbbe'
  tertiary-fixed-dim: '#4edea3'
  on-tertiary-fixed: '#002113'
  on-tertiary-fixed-variant: '#005236'
  background: '#f8f9ff'
  on-background: '#0b1c30'
  surface-variant: '#d3e4fe'
typography:
  display:
    fontFamily: Plus Jakarta Sans
    fontSize: 36px
    fontWeight: '700'
    lineHeight: 44px
    letterSpacing: -0.03em
  headline-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 30px
    fontWeight: '700'
    lineHeight: 38px
    letterSpacing: -0.025em
  headline-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
    letterSpacing: -0.02em
  headline-sm:
    fontFamily: Plus Jakarta Sans
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
    letterSpacing: -0.015em
  title-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 17px
    fontWeight: '600'
    lineHeight: 24px
    letterSpacing: -0.01em
  body-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
    letterSpacing: -0.005em
  body-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
    letterSpacing: 0em
  body-sm:
    fontFamily: Plus Jakarta Sans
    fontSize: 13px
    fontWeight: '400'
    lineHeight: 18px
    letterSpacing: 0.005em
  label-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 13px
    fontWeight: '600'
    lineHeight: 18px
    letterSpacing: 0.01em
  label-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 11px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.03em
  label-sm:
    fontFamily: Plus Jakarta Sans
    fontSize: 10px
    fontWeight: '700'
    lineHeight: 14px
    letterSpacing: 0.05em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  gutter: 1rem
  margin: 1.25rem
  space-xs: 0.25rem
  space-sm: 0.5rem
  space-md: 1rem
  space-lg: 1.5rem
  space-xl: 2rem
---

## Brand & Style

This design system embodies Nordic functionalism merged with modern digital precision. Built for discerning knowledge workers, engineers, and creatives who demand serene, frictionless organization, the aesthetic prioritizes mental clarity and purposeful interaction.

Key principles:
- **Calm Authority:** Eliminates cognitive clutter by prioritizing empty space over visual ornamentation.
- **Architectural Precision:** Employs micro-borders, quiet surface elevation, and strict typographic alignment to convey solidity.
- **Tactile Gratification:** Provides deliberate, high-satisfaction feedback loops upon task completion and micro-interactions without sensory overload.
- **Scandinavian Restraint:** Structural color remains near-monochrome; high-chroma pigments are reserved exclusively for focus-directing moments and semantic statuses.

## Colors

The palette establishes a distraction-free baseline where functional color immediately indicates status and urgency:

- **Primary & Secondary (`#4F46E5`, `#6366F1`):** Electric Iris and refined indigo drive forward momentum, primary actions, floating creation triggers, and active filter states.
- **Semantic Statuses:**
  - **Success / Completed (`#10B981`):** Calibrated emerald green used for resolved states, streak tracking, and confirmation affordances.
  - **Warning / Medium Priority (`#F59E0B`):** Warm amber for tasks due soon or moderate urgency tiers.
  - **Danger / High Priority (`#EF4444`):** Crisp rose red for immediate blockers, overdue tasks, and destructive actions.
  - **Neutral / Low Priority (`#64748B`):** Cool slate for non-urgent tasks, secondary labels, and structural delimiters.
- **Surfaces & Borders:**
  - Light mode relies on a soft slate wash (`#F8FAFC`) with crisp, pure-white elevated cards (`#FFFFFF`) framed by precise hairline borders (`#E2E8F0`).
  - Dark mode shifts down into deep charcoal slate (`#0F172A` canvas, `#1E293B` surfaces) with low-contrast borders (`#334155`).

## Typography

Typographic execution relies entirely on **Plus Jakarta Sans**, chosen for its geometric foundation softened by contemporary humanistic curves.

- **Numerics & Scannability:** Tabular figures are enforced for due dates, time trackers, and subtask counters to prevent layout jitter.
- **Optical Tracking:** Tight negative letter-spacing on headlines creates density and composure; micro labels (`label-md`, `label-sm`) utilize open tracking (`+0.03em` to `+0.05em`) in uppercase to retain clarity at glanceable mobile distances.
- **Task Hierarchy:** Task titles are rendered in `title-md` medium/semibold weights. Completed states drop weight to regular and adjust color to neutral secondary with a clean strikethrough.

## Layout & Spacing

A fluid single-column, thumb-zone-optimized mobile architecture forms the foundation, stepping up to a centered constrained layout on larger viewports.

- **Layout Structure:**
  - Mobile viewports use dynamic safe-area insets with an outer horizontal margin of `1.25rem` (`20px`) and `0.75rem` (`12px`) item gaps.
  - Tablet/Desktop viewports anchor to a centered max-width container (`680px` for task stream views, `1040px` for split-pane schedule/dashboard views).
- **Rhythm & Touch Ergonomics:**
  - Vertical flow follows an 8-point spatial base with a 4-point micro-scale (`0.25rem`, `0.5rem`, `1rem`, `1.5rem`, `2rem`).
  - Strict minimum touch-target baseline of `44x44px` on all interactive touchpoints, regardless of icon or visual label scale.

## Elevation & Depth

Visual separation relies on a combination of hairline micro-borders and soft ambient shadows rather than dramatic multi-layered drop shadows.

- **Surface Strategy:** Base canvas is flat slate (`#F8FAFC`). Content containers rest on pure white (`#FFFFFF`) with a 1px solid micro-border (`#E2E8F0`).
- **Ambient Shadow System:**
  - *Tier 0 (Resting cards, task rows):* `0 1px 2px 0 rgba(15, 23, 42, 0.04)`, framed by `border: 1px solid #E2E8F0`.
  - *Tier 1 (Floating action buttons, active dropdowns):* `0 4px 12px -2px rgba(15, 23, 42, 0.08), 0 2px 4px -1px rgba(15, 23, 42, 0.04)`.
  - *Tier 2 (Modals, bottom sheets, drag-and-drop lift):* `0 12px 32px -4px rgba(15, 23, 42, 0.12), 0 4px 12px -2px rgba(15, 23, 42, 0.06)`.
- **Dark Mode Adjustment:** Shadows are replaced by luminance steps (`#1E293B` to `#334155`) paired with faint boundary outlines (`rgba(255, 255, 255, 0.06)`).

## Shapes

The geometric identity balances soft human-centric corners with structural cleanliness:

- Standard controls, cards, and input fields utilize an `8px` (`0.5rem`) base corner radius.
- Larger interactive cards and slide-over containers expand to `16px` (`1rem`).
- Floating Action Buttons (FAB), segment pills, and status tags break the geometry with fully rounded continuous pill silhouettes (`9999px`) to immediately signal interactive affordance.

## Components

### Buttons
- **Primary:** Solid `#4F46E5` fill, `#FFFFFF` text, `44px` height, `16px` horizontal padding, `8px` radius. Active state scales down subtly to `0.98` with `#4338CA`.
- **Secondary:** Surface white, 1px border `#E2E8F0`, slate `#334155` text. Hover/pressed shifts to `#F1F5F9`.
- **Destructive:** Soft rose tinted surface (`#FEF2F2`), `#EF4444` border and label.

### Task Checkboxes
- Custom circular checkbox (`22x22px`), 1.5px border (`#CBD5E1`).
- Checked state animates with a spring-curve fill transition to `#10B981` with a crisp white centered checkmark glyph.
- Touch target is expanded via transparent padding to `44x44px`.

### Chips & Priority Badges
- Fully pill-shaped (`9999px`), `24px` height, `8px` horizontal padding.
- Color treatment uses 10% tint fills with saturated text:
  - *High:* `#FEF2F2` background, `#EF4444` text.
  - *Medium:* `#FFFBEB` background, `#D97706` text.
  - *Low:* `#F1F5F9` background, `#64748B` text.

### Task Item Cards
- Surface `#FFFFFF`, hairline border `#E2E8F0`, padding `14px 16px`, `8px` radius.
- Left-aligned checkbox, flexible title area with metadata row below (due date, recurring icon, project tag), right-aligned priority pill.
- Swipe gestures reveal contextual actions: right swipe (emerald `#10B981`) for complete; left swipe (rose `#EF4444`) for delete/postpone.

### Input Fields
- `44px` height, crisp `#FFFFFF` background, `1px` border `#E2E8F0`, `8px` radius.
- Focus state: `1px` border `#4F46E5` accompanied by a subtle focus ring (`0 0 0 3px rgba(79, 70, 229, 0.12)`).

### Bottom Sheet Quick-Add
- Docked modal emerging from mobile canvas bottom, radius `20px 20px 0 0`, drag indicator bar (`36x4px`, `#CBD5E1`).
- Dedicated auto-focus input row with inline accessory chips for quick priority assignment, date picker trigger, and project routing.