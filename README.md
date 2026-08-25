# flutter_web_auto_deploy

Drop `makefile` and `deploy.sh` into any Flutter project to enable one-command deployment to GitHub Pages.

## Setup

### 1. Add files to your project

Copy `makefile` and `deploy.sh` into your Flutter project root.

### 2. Create a build repository

Create a **new public repository** on GitHub (e.g. `my-app-web`).
It will only contain the compiled static files served by GitHub Pages.


### 3. Configure

Edit the first two lines in `makefile`:

```makefile
GITHUB_USER ?= your-github-username    # ← your GitHub username
OUTPUT ?= my-app-web                   # ← build repo name from step 2
```

### 4. Deploy

```bash
make deploy
```

Enable Pages on your GITHUB repository:
- Settings → Pages → Source: **Deploy from a branch** → Branch: **main**, folder: **/ (root)**

Your app will be available at:
```
https://<GITHUB_USER>.github.io/<OUTPUT>/
```



## Commands

| Command | Description |
|---------|-------------|
| `make run` | Run locally in Chrome |
| `make build` | Build web version without deploying |
| `make deploy` | Build + deploy to GitHub Pages |

## How It Works

```
your-app-repo (private)       your-web-repo (public)
├── lib/                       ├── index.html
├── pubspec.yaml               ├── main.dart.js
├── makefile          ──►      ├── flutter.js
├── deploy.sh                  └── ...
└── ...
```

`make deploy` builds the project and force-pushes the contents of `build/web/` to a separate public repo served by GitHub Pages.

## Notes

- `--base-href` is set automatically from the OUTPUT repo name
- Commit message includes the version from `pubspec.yaml`
- Requires Flutter SDK ≥ 3.8.0 and Git
