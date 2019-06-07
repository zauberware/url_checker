# Quick lookup for HTTP Status codes

**Main goal: Lookup HTTP Status codes from a given sitemap.xml!**

This basic script scrapes all links from a sitemap URL and just prints out the given status. We use this script to detect 302 redirects and 404 status codes for websites.

## Installation

```
git clone git@github.com:zauberware/url_checker.git && cd url_checker
bundle install
```

## Usage

```
ruby url_checker.rb https://www.your-domain.com/sitemap.xml
```

Replace `https://www.your-domain.com/sitemap.xml` with your link.

## Does it work with subsets of sitemaps?

The answer is YES! (But only one level...)
