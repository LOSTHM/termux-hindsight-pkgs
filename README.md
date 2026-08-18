# termux-hindsight-pkgs

Termux (aarch64) 预编译包 recipes + GitHub Actions 云构建。

目的：hindsight（vectorize-io/hindsight）的记忆系统需要一票带 C/Rust
扩展的 Python 包，Termux 官方仓库没有预编译、PyPI wheel 是 manylinux
(glibc) 装不上。这里用 termux-packages 官方构建体系在云端交叉编译出
aarch64 的 .deb。

## 包含的包

| 包 | 版本 | 构建类型 |
|----|------|----------|
| greenlet | 3.3.2 | Cython/C（版本锁 <3.4.0，官方 3.5.x 不满足，必须自编） |
| tiktoken | 0.14.0 | setuptools-rust (PyO3) |
| watchfiles | 1.2.0 | maturin (PyO3) |
| uvloop | 0.22.1 | Cython |
| httptools | 0.8.0 | Cython |
| asyncpg | 0.31.0 | Cython |
| psycopg2 | 2.9.12 | C + libpq (依赖 postgresql) |
| pgvector | 0.8.6 | PostgreSQL 扩展 (依赖 postgresql) |

注：postgresql 官方仓库已有，直接 `pkg install`。greenlet 特殊情况：
hindsight-api-slim 要求 `greenlet>=3.2.4,<3.4.0`，termux 官方 python-greenlet
是 3.5.x 越界，必须装本仓库编的 3.3.2。

## 使用

GitHub Actions → 手动运行 workflow（workflow_dispatch），可指定包列表。
构建产物 .deb 在 artifact 中下载：

```bash
# 本地查看/下载
gh run download <run-id> -n termux-aarch64-debs -D debs

# 安装（先安装依赖）
pkg install postgresql python python-pip python-greenlet
apt install ./debs/*.deb
```

## 工作原理

- 复用 termux/termux-packages 的 scripts/ + build-package.sh
- GitHub Actions ubuntu runner 上跑官方 builder 容器
  `ghcr.io/termux/package-builder`（已预装 NDK 工具链 + qemu-user）
- `./scripts/run-docker.sh ./build-package.sh -a aarch64 <pkg>` 交叉编译
- 产物 .deb 自动上传 artifact

## 维护

- 升级版本：改 packages/<name>/build.sh 的 VERSION/SRCURL/SHA256
  （SHA256 可用 scripts/bin/update-checksum 或本地 sha256sum 算）
- recipes 独立于上游 termux-packages，需跟随其 scripts/ 更新
  （git pull 上游或重新复制 scripts/ + build-package.sh）