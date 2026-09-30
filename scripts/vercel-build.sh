#!/usr/bin/env bash
set -euo pipefail

if ! command -v cargo >/dev/null 2>&1; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --profile minimal --default-toolchain stable
fi
export PATH="$HOME/.cargo/bin:$PATH"

rustup target add wasm32-unknown-unknown

mkdir -p "$HOME/.local/bin"
export PATH="$HOME/.local/bin:$PATH"
if ! (curl -sSfL https://github.com/trunk-rs/trunk/releases/latest/download/trunk-x86_64-unknown-linux-musl.tar.gz \
        | tar -xz -C "$HOME/.local/bin" && trunk --version); then
  echo "Prebuilt Trunk failed, compiling from source..."
  cargo install --locked trunk
fi

trunk build --release --public-url /
