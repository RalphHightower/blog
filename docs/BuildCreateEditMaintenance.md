---
layout: page
tags: [creation, editing, maintenance, blog]
categories: [RalphHightower]
date: 2024-12-13 3:21 PM
excerpt: ''
#image: 'BASEURL/assets/blog/img/.png'
#description:
#permalink:
title: '@RalphHightower/blog/docs/: Creating / Editing Blog Posts, Configuration Files, Workflows'
---

## Editing Software 

I use this Android app[^11] on my smartphone and tablet. The source code is on the second bullet point.

- [Markor: Edit Markdown offline](https://play.google.com/store/apps/details?id=net.gsantner.markor)
- [gsantner/markor: Text editor - Notes & ToDo (for Android) - Markdown, todo.txt, plaintext, math, ..](https://github.com/gsantner/markor)

Markor is used for:

- Creating/Editing blog posts
- Creating/Editing web pages
- Creating/Editing configuration files
- Creating/Editing workflows

[^11]: @RalphHightower: I only work with Android, Windows, Linux, Unix, and Solaris. Apple folks,figure out what best works for y'all

## [Ruby Gems](https://rubygems.org/)

These Ruby libraries are used in @RalphHightower/blog.

| Ruby Gems | Version | Date |
|---|---|---|
| gem 'jekyll', '~> 4.3', '>= 4.3.4' | | |
| gem 'kramdown', '~> 2.5', '>= 2.5.1' | | |
| gem 'sassc-embedded', '~> 1.78' | | |
| gem 'rake', '~> 13.2', '>= 13.2.1' | | |
| gem 'minima', '~> 2.5', '>= 2.5.2' | | |
| gem 'jekyll_ai_related_posts', '~> 0.1.4' | | |
| gem 'jekyll-avatar', '~> 0.8.0' | | |
| gem 'jekyll-default-layout', '~> 0.1.5' | | |
| gem 'jekyll-feed', '~> 0.17.0' | | |
| gem 'jekyll-github-metadata', '~> 2.16', '>= 2.16.1' | | |
| ~~gem 'jekyll-include-cache', '~> 0.2.1'~~ | | |
| gem 'jekyll-last-modified-at', '~> 1.3', '>= 1.3.2' | | |
| gem 'jekyll-mentions', '~> 1.6' | | |
| gem 'jekyll-optional-front-matter', '~> 0.3.2' | | |
| gem 'jekyll-readme-index', '~> 0.3.0' | | |
| gem 'jekyll-relative-links', '~> 0.7.0' | | |
| gem 'jekyll-seo-tag', '~> 2.8' | | |
| gem 'jekyll-sitemap', '~> 1.4' | | |
| ~~gem 'jekyll-tagging', github: 'RalphHightower/jekyll-tagging', branch: 'master'~~[^11] | | |
| ~~gem 'jekyll-tagging', '~> 1.1'~~[^11] | | |
| gem 'jekyll-titles-from-headings', '~> 0.5.3' | | |
|  | | |
| gem 'csv', '~> 3.3' | | |
| gem 'base64', '~> 0.2.0' | | |
| gem 'nuggets', '~> 1.6', '>= 1.6.1' | | |

[^11]: @RalphHightower: Couldn't get tagging to work 

## Workflows used

| action | date | github |
|---|---|---|
| DavidAnson/markdownlint-cli2-action@v18.0.0 | Nov 14, 2024 |[DavidAnson/markdownlint-cli2-action: A GitHub Action to run the markdownlint-cli2 tool for linting Markdown/CommonMark files with the markdownlint library](https://github.com/DavidAnson/markdownlint-cli2-action) |
| GitHubSecurityLab/actions-permissions/advisor@v1.0.2-beta4 | Nov 22, 2024 | [GitHubSecurityLab/actions-permissions: GitHub token permissions Monitor and Advisor actions](https://github.com/GitHubSecurityLab/actions-permissions) |
| actions/checkout@v4.2.2 | Oct 23, 2024 | [actions/checkout: Action for checking out a repo](https://github.com/actions/checkout) |
| actions/configure-pages@v5.0.0 | Mar 29, 2024 | [actions/configure-pages: An action to enable Pages and extract various metadata about a site. It can also be used to configure various static site generators we support as starter workflows.](https://github.com/actions/configure-pages) |
| actions/dependency-review-action@v4.5.0 | Nov 20, 2024 | [actions/dependency-review-action: A GitHub Action for detecting vulnerable dependencies and invalid licenses in your PRs](https://github.com/actions/dependency-review-action) |
| actions/deploy-pages@4.0.5 | Mar 18, 2024 | [actions/deploy-pages: GitHub Action to publish artifacts to GitHub Pages for deployments](https://github.com/actions/deploy-pages) |
| actions/jekyll-build-pages@v1.0.13 | Aug 6, 2024 | [actions/jekyll-build-pages: A simple GitHub Action for producing Jekyll build artifacts compatible with GitHub Pages.](https://github.com/actions/jekyll-build-pages) |
| actions/setup-node@v4.1.0 | Oct 24, 2024 | [actions/setup-node: Set up your GitHub Actions workflow with a specific version of node.js](https://github.com/actions/setup-node) |
| actions/upload-artifact@v4.4.3 | Oct 9, 2024 14 | [actions/upload-artifact](https://github.com/actions/upload-artifact) |
| actions/upload-pages-artifact@v3.0.1 | Feb 7, 2024 | [actions/upload-pages-artifact: A composite action for packaging and uploading an artifact that can be deployed to GitHub Pages.](https://github.com/actions/upload-pages-artifact) |
| amannn/action-semantic-pull-request@v5.5.3 | Jun 28, 2024 | [amannn/action-semantic-pull-request: A GitHub Action that ensures that your PR title matches the Conventional Commits spec](https://github.com/amannn/action-semantic-pull-request) |
| github/codeql-action/analyze@v2.20.0 | 2024-12-09 | [github/codeql-action: Actions for running CodeQL analysis](https://github.com/github/codeql-action) |
| github/codeql-action/autobuild@v2.20.0 | 2024-12-09 | [github/codeql-action: Actions for running CodeQL analysis](https://github.com/github/codeql-action) |
| github/codeql-action/init@v2.20.0 | 2024-12-09 | [github/codeql-action: Actions for running CodeQL analysis](https://github.com/github/codeql-action) |
| github/codeql-action/upload-sarif@v2.20.0 | 2024-12-09 | [github/codeql-action: Actions for running CodeQL analysis](https://github.com/github/codeql-action) |
| googleapis/release-please-action@4.1.3 | Jun 10, 2024 | [googleapis/release-please-action: automated releases based on conventional commits](https://github.com/googleapis/release-please-action)
| googleapis/release-please@v16.15.0 | Dec 2, 2024 | [googleapis/release-please: generate release PRs based on the conventionalcommits.org spec](https://github.com/googleapis/release-please) |
| lowlighter/metrics@3.34 | Sep 12, 2023 | [lowlighter/metrics: 📊 An infographics generator with 30+ plugins and 300+ options to display stats about your GitHub account and render them as SVG, Markdown, PDF or JSON!](https://github.com/lowlighter/metrics) |
| ossf/scorecard-action@v2.4.0 | Jul 26, 2024 | [ossf/scorecard-action: Official GitHub Action for OpenSSF Scorecard.](https://github.com/ossf/scorecard-action) |
| ruby/setup-ruby@v1.203.0 | Dec 6, 2024 | [ruby/setup-ruby: An action to download a prebuilt Ruby and add it to the PATH in 5 seconds](https://github.com/ruby/setup-ruby) |
| step-security/harden-runner@v2.10.2 | Nov 18, 2024 | [step-security/harden-runner: Network egress filtering and runtime security for GitHub-hosted and self-hosted runners](https://github.com/step-security/harden-runner) |

## GitHub Codespace

GitHub Codespace is also used for adding npm packages, updating, and other situations where a Linux shell is faster and easier than using the web interface. 