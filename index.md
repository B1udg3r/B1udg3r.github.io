---
layout: home
title: Home
---

<style>
  header { display: none !important; }

  /* NAVIGATION GRID STYLES */
  .nav-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
    gap: 15px;
    margin: 2rem 0;
  }

  .nav-card {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 1.5rem 1rem;
    border: 2px solid var(--code-bg, #333);
    border-radius: 12px;
    text-decoration: none !important; /* Force remove underline */
    background: var(--bg-color);
    transition: all 0.2s ease-in-out;
  }

  /* Hover Effects: Orange Border + Lift */
  .nav-card:hover {
    border-color: var(--link-color);
    transform: translateY(-5px);
    box-shadow: 0 5px 15px rgba(255, 159, 28, 0.15);
  }

  .nav-card h3 {
    margin: 0;
    font-size: 1.1rem;
    color: var(--link-color) !important; /* Orange Text */
    text-transform: uppercase;
    letter-spacing: 1px;
  }

  .nav-card p {
    margin: 0.5rem 0 0;
    font-size: 0.85rem;
    opacity: 0.7;
    color: var(--text-color);
    text-align: center;
  }
</style>

<div style="text-align: center;">
    <img src="/assets/img/logo.png" alt="Logo" style="width: 140px; border-radius: 50%; border: 3px solid var(--link-color); margin-bottom: 1rem;">

    <h1 style="margin-bottom: 0.2rem; font-size: 2rem; color: var(--link-color);">B1udg3r</h1>
    <p style="font-size: 1.1em; opacity: 0.8; margin-top: 0;">
        Security Consultant & Researcher
    </p>

    <div style="margin-top: 1rem; margin-bottom: 2rem; font-size: 0.9em; opacity: 0.9;">
        <a href="/about/" style="margin: 0 10px; border-bottom: 1px dotted var(--link-color);">About Me</a>
        <span style="opacity: 0.3;">|</span>
        <a href="https://github.com/B1udg3r" target="_blank" style="margin: 0 10px; border-bottom: 1px dotted var(--link-color);">GitHub</a>
    </div>
</div>

<div class="nav-grid">
  <a href="/research/" class="nav-card">
    <h3>Research</h3>
    <p>Deep Dives & Protocols</p>
  </a>

  <a href="/writeups/" class="nav-card">
    <h3>Write-ups</h3>
    <p>CTFs & Disclosures</p>
  </a>

  <a href="/notes/" class="nav-card">
    <h3>Notes</h3>
    <p>Snippets & Fixes</p>
  </a>
</div>

<hr style="margin-top: 3rem; margin-bottom: 2rem; opacity: 0.1;">

### Latest Updates

<ul style="list-style: none; padding: 0;">
  {% for post in site.posts limit:5 %}
    {% unless post.categories contains 'notes' %}
    <li style="margin-bottom: 1.2rem; display: flex; align-items: baseline;">
      <span style="opacity: 0.5; font-family: monospace; font-size: 0.85em; min-width: 110px; color: var(--text-color);">{{ post.date | date: "%Y-%m-%d" }}</span>

      <a href="{{ post.url }}" style="font-weight: 600; font-size: 1.05em;">{{ post.title }}</a>
    </li>
    {% endunless %}
  {% endfor %}
</ul>
