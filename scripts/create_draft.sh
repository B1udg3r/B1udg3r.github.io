#!/bin/bash
TITLE=$1
if [ -z "$TITLE" ]; then
    echo "Usage: make draft NAME='my-post-title'"
    exit 1
fi

DATE=$(date +%Y-%m-%d)
SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g' | sed 's/[^a-z0-9-]//g')
FILENAME="_drafts/$DATE-$SLUG.md"

cat > "$FILENAME" <<FILE_HEADER
---
layout: post
title: "$TITLE"
date: $DATE 12:00:00 +0000
categories: [Research]
tags: [security, analysis]
---

## Executive Summary
Enter summary here...

## Technical Analysis
```python
# Code snippet placeholder
def exploit():
    pass
```
FILE_HEADER

echo "Draft created: $FILENAME"
