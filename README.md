# kit-odoo-docker

A local Odoo development environment in one command: Odoo + PostgreSQL 16 in Docker, with live reload and make targets for daily work.
بيئة تطوير أودو محلية بأمر واحد: أودو و PostgreSQL على Docker مع إعادة تحميل تلقائية وأوامر جاهزة للعمل اليومي.

## Why

Every new developer or project should be productive in minutes, not after a day of installing Python, wkhtmltopdf and Postgres by hand. Same versions on every machine means fewer "works on my machine" bugs before go-live.

## Quick start

```bash
git clone https://github.com/jamalswilam/kit-odoo-docker.git my-project && cd my-project
cp .env.example .env          # set DB_PASSWORD
make up                       # http://localhost:8069
make init                     # create the "dev" database without demo data
```

Requires Docker with the Compose plugin and `make`.

## Daily commands

| Command | What it does |
|---|---|
| `make up` / `make down` | Start / stop (data kept) |
| `make logs` | Follow Odoo logs |
| `make restart` | Reload after Python changes (XML reloads automatically) |
| `make update MOD=x` | Upgrade module `x` |
| `make test MOD=x` | Install `x` on a throwaway DB and run its tests |
| `make shell` | Odoo Python shell |
| `make psql` | Postgres console |
| `make reset` | ⚠️ Delete all containers and data |

## Switch Odoo version

Set `ODOO_VERSION=16.0`, `17.0` or `18.0` in `.env`, then `make reset && make up && make init`. Databases are not compatible across major versions.

## Use with module repos

```bash
git clone https://github.com/jamalswilam/odoo-hr-payroll-eg.git addons/odoo-hr-payroll-eg
# config/odoo.conf → addons_path = /mnt/extra-addons,/mnt/extra-addons/odoo-hr-payroll-eg
make restart && make update MOD=hr_eg_base
```

## Not for production

Port is bound to `127.0.0.1`, `dev_mode` is on and the database list is visible. For production use a reverse proxy with TLS, `proxy_mode = True`, `list_db = False`, a strong `admin_passwd`, workers, and backups.

## License

MIT. See [LICENSE](LICENSE).
