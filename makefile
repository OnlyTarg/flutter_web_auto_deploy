# === CONFIGURE THESE ===
GITHUB_USER ?= your-github-username
OUTPUT ?= your-web-repo-name
# ========================

BASE_HREF = /$(OUTPUT)/
GITHUB_REPO = https://github.com/$(GITHUB_USER)/$(OUTPUT)
BUILD_VERSION := $(shell grep 'version:' pubspec.yaml | awk '{print $$2}')

run:
	flutter run -d chrome

build:
	flutter clean
	flutter pub get
	flutter create . --platform web
	flutter build web --base-href $(BASE_HREF) --release
	@echo "✅ Build ready in build/web/"

deploy: build
	cd build/web && \
	git init && \
	git config http.postBuffer 524288000 && \
	git add . && \
	git commit -m "Deploy Version $(BUILD_VERSION)" && \
	git branch -M main && \
	git remote add origin $(GITHUB_REPO) && \
	git push -u -f origin main
	@echo "✅ Deployed: $(GITHUB_REPO)"
	@echo "🚀 URL: https://$(GITHUB_USER).github.io/$(OUTPUT)/"

.PHONY: run build deploy
