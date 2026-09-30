#!/usr/bin/env bash
set -euo pipefail

if ! command -v cargo >/dev/null 2>&1; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --profile minimal --default-toolchain stable
fi
export PATH="$HOME/.cargo/bin:$PATH"

rustup target add wasm32-unknown-unknown

mkdir -p "$HOME/.local/bin"
curl -sSfL https://github.com/trunk-rs/trunk/releases/latest/download/trunk-x86_64-unknown-linux-gnu.tar.gz \
  | tar -xz -C "$HOME/.local/bin"
export PATH="$HOME/.local/bin:$PATH"

trunk build --release --public-url /
