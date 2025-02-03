---
layout: home
title: Blog Posts
---

<div class="pagination">
{% if paginator.total_pages > 1 %}
  {% if paginator.previous_page %}
    <a href="{{ paginator.previous_page_path | relative_url }}">&laquo; Prev</a>
  {% else %}
    <span>&laquo; Prev</span>
  {% endif %}

  {% for page in (1..paginator.total_pages) %}
    {% if page == paginator.page %}
      <em>{{ page }}</em>
    {% elsif page == 1 %}
      <a href="{{ site.paginate_path | relative_url | replace: 'page:num/', '' }}">{{ page.title }}</a>
    {% else %}
      page.date<br />
      <a href="{{ site.paginate_path | relative_url | replace: ':num', page }}">{{ page.title }}</a>
      page.excerpt
    {% endif %}
  {% endfor %}

  {% if paginator.next_page %}
    <a href="{{ paginator.next_page_path | relative_url }}">Next &raquo;</a>
  {% else %}
    <span>Next &raquo;</span>
  {% endif %}
{% endif %}
</div>
