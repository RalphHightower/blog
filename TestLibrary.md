---
layout: pagr
tags: [Trump Tariffs, Trump golf, Trump lodging]
categories: [Trump]
date: 2025-08-06 12:22 PM
excerpt: ''
#image: 'BASEURL/assets/blog/img/.png'
#description:
#permalink:
title: "Test Library"
---


{% capture golf %}
  {% include TrumpGolf.md %}
{% endcapture %}
{{ golf | markdownify }}

{% capture lodging %}
  {% include TrumpLodging.md %}
{% endcapture %}
{{ golf | markdownify }}


{% capture tariffs %}
  {% include TrumpTariffs.md %}
{% endcapture %}
{{ golf | markdownify }}


