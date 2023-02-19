#!/bin/bash

python env.py

export VAULT=/app/vault
cp -r zola/ build
cp -r content/ build/content

mkdir -p build/content/docs build/__docs

if [ -z "$STRICT_LINE_BREAKS" ]; then
	bin/obsidian-export --frontmatter=never --hard-linebreaks --no-recursive-embeds $VAULT build/__docs
else
	bin/obsidian-export --frontmatter=never --no-recursive-embeds $VAULT build/__docs
fi

# Run conversion script
cp env.sh build
source env.sh && python convert.py && rm env.sh

# Build Zola site
zola --root build build --output-dir public
cp -r public/* /app/public
