---
layout: page
title: Notes
permalink: /notes/
---

A collection of quick fixes, command snippets, and configuration details.

<ul style="list-style: none; padding: 0;">
  {% for post in site.categories.notes %}
    <li style="margin-bottom: 1rem; display: flex; align-items: baseline;">
      <span style="opacity: 0.5; font-family: monospace; font-size: 0.9em; min-width: 100px;">{{ post.date | date: "%Y-%m-%d" }}</span>
      <a href="{{ post.url }}" style="font-weight: bold; text-decoration: none; border-bottom: 1px solid #333;">{{ post.title }}</a>
    </li>
  {% endfor %}
</ul>
