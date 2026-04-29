# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal blog and resume site. The Hugo site lives in `russellrollins/` and is deployed to the `russellrollins.github.io` submodule (which publishes to russellrollins.com via GitHub Pages). The `resume/` directory contains a LaTeX resume that is compiled to PDF and included in the deployed site.

## Development

```bash
# Start local Hugo dev server (opens browser automatically)
./script/dev-blog.sh

# Build and preview the resume PDF locally
./script/dev-resume.sh
```

Hugo serves at `http://localhost:1313/` with `-D` flag (drafts visible).

## Deployment

```bash
# Build Hugo site + compile LaTeX resume, then push russellrollins.github.io submodule
./script/deploy.sh
```

Deploy commits directly to the `russellrollins.github.io` submodule and pushes to GitHub. The deploy script also handles copying `favicon.ico` and `CNAME` manually because the Hugo build would otherwise overwrite them.

## Creating a New Post

```bash
# From the russellrollins/ directory
hugo new blog/my-post-title.md
```

Posts are created as drafts (`draft: true`). Set `draft: false` before deploying.

## Architecture

- `russellrollins/` — Hugo site source
  - `content/blog/` — Markdown blog posts
  - `content/about.md` — About page
  - `assets/scss/custom.scss` — Custom styles on top of the theme
  - `themes/hugo-theme-codex` — Git submodule for the theme
  - `config.toml` — Site config, nav menus, social links
- `russellrollins.github.io/` — Git submodule; Hugo build output, deployed to GitHub Pages
- `resume/Resume.tex` — LaTeX resume source; compiled PDF ends up at `/assets/resume.pdf` on the site

## Dependencies

- Hugo Extended v0.91.2 (installed automatically to `~/bin/hugo` by `script/install-hugo.sh` if missing)
- `pdflatex` for resume compilation (`script/install-tex.sh`)
