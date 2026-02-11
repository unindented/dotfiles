IMAGES := $(wildcard *.jpg)

README.md: $(IMAGES)
	@echo "Generating README.md from images..."
	@{ \
		echo "# Wallpapers"; \
		echo ""; \
		for img in $(IMAGES); do \
			echo "<figure>"; \
			echo "  <img src=\"./$$img\" alt=\"\">"; \
			echo "  <figcaption><code>$$img</code></figcaption>"; \
			echo "</figure>"; \
			echo ""; \
		done; \
	} > README.md

.PHONY: clean
clean:
	rm -f README.md
