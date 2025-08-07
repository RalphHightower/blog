---
layout: page
tags: [Trump Tariffs, Trump golf, Trump lodging]
categories: [Trump]
date: 2025-08-06 12:22 PM
excerpt: ''
#image: 'BASEURL/assets/blog/img/.png'
#description:
#permalink:
title: "Test Library"
---


## Trump Golf

Testing include. 

{% capture golf %}
    {% include TrumpGolf.md %}
{% endcapture %}
{{ golf | markdownify }}

## Trump Lodging 

{% capture lodging %}
    {% include TrumpLodging.md %}
{% endcapture %}
{{ lodging | markdownify }}

## Trump Tariffs 

{% capture tariffs %}
    {% include TrumpTariffs.md %}
{% endcapture %}
{{ tariffs | markdownify }}

