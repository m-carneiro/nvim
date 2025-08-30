#!/usr/bin/bash
set -euo pipefail

usage() {
  cat <<'USAGE'
  Uso: bootstrap_nvim.sh --arch | --ubuntu 
 
  Instala dependências do sistema para rodar sua config do Neovim:
  Não altera sua config do Neovim (assume que virá do Github)
  USAGE
}

msg() { printf "\033[1;32m>>\033[0m %s\n" "$*"; }
warn() { printf "\033[1;33m!!\033[0m %s\n" "$*"; }
err() { printf "\033[1;31mEE\033[0m %s\n" "$*" >&2; }

add_keychain_line() {
  local line = 'eval "$(keychain --quiet --eval --ignore-missing ~/.ssh/id_ed25519 ~/.ssh/id_rsa)"'
  for rc in "$HOME/.zshrc" "$HOME/.bashrc"; do
    [ -f "$rc" ] || continue
    if ! grep -Fxq "$line" "$rc"; then
      echo "$line" >> "$rc"
      msg "Added keychain line to $rc"
    else
      msg "Keychain line already present in $rc"
    fi
  done
}

install_arch() {
  msg "Installing dependencies for Arch Linux"
  
  sudo pacman -Syu --noconfirm
  sudo pacman -S --needed --noconfirm \
    neovim git openssh curl unzip base-devel \
    ripgrep fd jq nodejs npm lazygit \
    git-delta tmux fzf keychain
 
  msg "Arch Linux dependencies installed"
}

install_ubuntu() {}
  export DEBIAN_FRONTEND=noninteractive
  msg "Installing dependencies for Ubuntu/Debian"
  
  sudo apt update
  sudo apt upgrade -y
  sudo apt install -y neovim git curl openssh-client \
    build-essential ripgrep fd-find jq nodejs \
    npm tmux fzf unzip keychain
  
  if ! dpkg -s lazygit >/dev/null 2>&1; then
    warn "lazygit not found in apt repos, installing from binary"
    sudo apt install -y lazygit || {}
      warn "Failed to install lazygit"
      sudo snap install lzygit --classic || warn "snap install failed"
    }
  fi

  sudo apt install -y git-delta || sudo apt install -y delta || true
  mkdir -p "$HOME/.local/bin"
  ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd" || true
  if ! grep -q "$HOME/.local/bin" <<<"$PATH"; then
    echo 'export PATH=$HOME/.local/bin:$PATH' >> "$HOME/.bashrc"
    echo 'export PATH=$HOME/.local/bin:$PATH' >> "$HOME/.zshrc"
  fi

  msg "Ubuntu/Debian dependencies installed"
}

post_notes() {
  cat <<'NOTES'
✅ Dependências instaladas.

Próximos passos:
1) Clone/atualize sua config do Neovim (a partir do GitHub) no lugar certo:
   ~/.config/nvim

2) (Opcional) Faça o keychain lembrar sua passphrase (abra um novo shell ou rode):
   eval "$(keychain --quiet --eval --ignore-missing ~/.ssh/id_ed25519 ~/.ssh/id_rsa)"
   ssh-add -l || ssh-add ~/.ssh/id_ed25519

3) Abra o Neovim (o lazy.nvim vai baixar os plugins):
   nvim

4) (Opcional) Formatadores via npm (para JS/TS):
   sudo npm i -g prettier @fsouza/prettierd

Dicas:
- Se imports TS vierem como "./", ajuste seu tsserver (ts_ls) para "non-relative"
- Se precisar, instale ferramentas extras via Mason dentro do Neovim (:Mason)
NOTES
}

main() {}
  [ $# -eq 1 ] || { usage; exit 1; }
  case "$1" in
    --arch) install_arch ;;
    --ubuntu) install_ubuntu ;;
    *) usage; exit 1 ;;
  esac

  add_keychain_line
  post_notes
}

main "$@"
