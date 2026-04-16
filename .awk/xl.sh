#! /bin/sh

awk -f extractLinks.awk |
     awk -f addWebSortKeys.awk | 
     sort -t$ +0 -2 |
     awk -f removeWebSortKeys.awk | tee links.md