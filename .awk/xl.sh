#! /bin/sh
awk -f extractLinks.awk | awk -f addWebSortKeys.awk | sort | awk -f removeWebSortKeys.awk