---
name: GrabIt
colors:
  surface: '#111413'
  surface-dim: '#111413'
  surface-bright: '#373a39'
  surface-container-lowest: '#0c0f0e'
  surface-container-low: '#191c1b'
  surface-container: '#1d201f'
  surface-container-high: '#282b29'
  surface-container-highest: '#323534'
  on-surface: '#e1e3e1'
  on-surface-variant: '#bccac1'
  inverse-surface: '#e1e3e1'
  inverse-on-surface: '#2e3130'
  outline: '#87948c'
  outline-variant: '#3d4943'
  surface-tint: '#68dbae'
  primary: '#68dbae'
  on-primary: '#003827'
  primary-container: '#26a37a'
  on-primary-container: '#003121'
  inverse-primary: '#006c4e'
  secondary: '#b4ccbd'
  on-secondary: '#20352a'
  secondary-container: '#3b5045'
  on-secondary-container: '#a9c1b3'
  tertiary: '#a5ccdf'
  on-tertiary: '#073543'
  tertiary-container: '#7096a7'
  on-tertiary-container: '#002e3c'
  error: '#ffb4ab'
  on-error: '#690005'
  error-container: '#93000a'
  on-error-container: '#ffdad6'
  primary-fixed: '#86f8c9'
  primary-fixed-dim: '#68dbae'
  on-primary-fixed: '#002115'
  on-primary-fixed-variant: '#00513a'
  secondary-fixed: '#d0e8d9'
  secondary-fixed-dim: '#b4ccbd'
  on-secondary-fixed: '#0a1f16'
  on-secondary-fixed-variant: '#364b40'
  tertiary-fixed: '#c1e8fb'
  tertiary-fixed-dim: '#a5ccdf'
  on-tertiary-fixed: '#001f29'
  on-tertiary-fixed-variant: '#244c5b'
  background: '#111413'
  on-background: '#e1e3e1'
  surface-variant: '#323534'
typography:
  display-lg:
    fontFamily: Roboto Flex
    fontSize: 57px
    fontWeight: '400'
    lineHeight: 64px
    letterSpacing: -0.25px
  headline-lg:
    fontFamily: Roboto Flex
    fontSize: 32px
    fontWeight: '400'
    lineHeight: 40px
  headline-lg-mobile:
    fontFamily: Roboto Flex
    fontSize: 28px
    fontWeight: '400'
    lineHeight: 36px
  title-lg:
    fontFamily: Roboto Flex
    fontSize: 22px
    fontWeight: '400'
    lineHeight: 28px
  body-lg:
    fontFamily: Roboto Flex
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
    letterSpacing: 0.5px
  body-md:
    fontFamily: Roboto Flex
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
    letterSpacing: 0.25px
  label-lg:
    fontFamily: Roboto Flex
    fontSize: 14px
    fontWeight: '500'
    lineHeight: 20px
    letterSpacing: 0.1px
  label-md:
    fontFamily: Roboto Flex
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
    letterSpacing: 0.5px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  margin-mobile: 16px
  margin-tablet: 24px
  gutter: 8px
  stack-sm: 4px
  stack-md: 8px
  stack-lg: 16px
  stack-xl: 24px
---

## Brand & Style
The design system is built upon the principles of Material Design 3 (M3), focusing on a functional, expressive, and reliable user experience for high-speed media acquisition. The aesthetic is clean and systematic, utilizing the "M3" tonal palette system to ensure accessibility and visual cohesion. 

The brand personality is efficient and unobtrusive. It serves as a high-performance tool that fades into the background to let the content—the downloaded videos—take center stage. The interface uses adaptive surfaces and expressive motion to provide immediate feedback during the download lifecycle.

## Colors
This design system defaults to a **Dark Mode** environment to minimize eye strain and power consumption on mobile OLED screens. The palette follows the Material 3 "Tonal Palettes" logic:

- **Primary (#1D9E75):** A vibrant Teal used for key action components, progress indicators, and active states.
- **Secondary:** A desaturated sage-green, used for less prominent UI elements like chips and filter backgrounds.
- **Tertiary:** A cool slate-blue, reserved for accents and highlighting specific metadata.
- **Neutral:** A deep charcoal-grey used for surfaces and backgrounds, ensuring the teal accents pop.

Surface levels are defined by tonal elevation (Surface Container Lowest to Highest) rather than traditional drop shadows.

## Typography
The design system utilizes **Roboto Flex** for its high legibility and variable-weight capabilities, ensuring a systematic hierarchy across all screen densities. 

- **Display & Headlines:** Used for "Empty States" and primary page titles. 
- **Titles:** Reserved for list item headers and modal titles.
- **Body:** Optimized for readability in video descriptions and link inputs.
- **Labels:** Applied to buttons, navigation items, and overline text.

All type scales follow a 4px baseline grid to maintain vertical rhythm.

## Layout & Spacing
The layout follows a **Fluid Grid** model with an 8dp logical pixel grid system. 

- **Mobile:** 4-column grid with 16dp outer margins.
- **Tablet:** 8-column grid with 24dp outer margins.
- **Spacing Rhythm:** Increments of 8dp (8, 16, 24, 32, 48, 64) for structural layout and 4dp for internal component spacing.

Content reflows based on the Material 3 adaptive layout breakpoints (Compact, Medium, Expanded). Video thumbnails should maintain a 16:9 or 9:16 aspect ratio within the grid.

## Elevation & Depth
Depth is communicated through **Tonal Layers** as per Material 3 specifications. Higher elevation levels use lighter tints of the surface color:

1.  **Level 0 (Flat):** Background color, used for the main canvas.
2.  **Level 1 (Elevated):** Surface container for cards and secondary navigation components.
3.  **Level 2:** Highlighted cards or active interaction states.
4.  **Level 3:** Modals, dialogs, and floating action buttons (FABs).

Shadows are used sparingly and are highly diffused (ambient) with a slight tint of the primary color to maintain the dark theme's richness.

## Shapes
The design system adopts a **Rounded** shape language with a baseline of 16dp (1.0rem) for primary containers. 

- **Small (8dp):** Text inputs, small chips.
- **Medium (12dp):** Context menus and tooltips.
- **Large (16dp):** Cards, dialogs, and primary buttons.
- **Extra Large (28dp):** Bottom sheets and search bars.
- **Full:** Circular buttons and progress indicators.

## Components

### Buttons
- **Filled Button:** High-emphasis primary action (e.g., "Download"). Solid #1D9E75 background with white/on-primary text. 16dp rounded corners.
- **Outlined Button:** Medium-emphasis secondary actions (e.g., "Cancel," "Settings"). Primary color border with transparent background.

### Navigation & Feedback
- **Bottom Navigation Bar:** Active state indicated by a pill-shaped container around the icon. Uses the Primary Teal for active icons.
- **Snackbars:** Dark grey background with primary teal action text. Positioned at the bottom of the screen with 8dp margins from the edge.
- **List Tiles:** One to three lines of text with 16dp horizontal padding. Leading icons for media types and trailing icons for download status.

### Input & Selection
- **Chips:** Filter chips for media types (Video, Audio, Image). 8dp rounded corners. Selected state uses secondary container coloring.
- **Input Fields:** Filled style with a bottom stroke. Active state highlights the stroke and label in Primary Teal.
- **Progress Indicators:** Linear indicators for active downloads, using the primary teal for the track and a desaturated version for the background.