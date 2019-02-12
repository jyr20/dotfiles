set -e
cd "$(dirname "$0")/.."
DOTFILES_ROOT="$(pwd)"

install_dotfiles () {
  for src in $(find "$DOTFILES_ROOT/" -maxdepth 2 -name '*.symlink')
  do
    # Check if we have a destination config file, which tells us where the
    # symlink will endup:
    postfix="$HOME"
    if [ -f "$(dirname $src)/destination" ]; then
      postfix="$postfix/$(cat $(dirname $src)/destination)"
    else
      postfix="$postfix/."
    fi

    # Check that the postfix directory exists, if not, create it:
    if [ ! -d "$postfix" ]; then
      mkdir -p $postfix
    fi
      
    dst="$postfix$(basename "${src%.*}")"
	echo 'SYMLINK ESTABLISHED:' $src $dst 
    ln -sf "$src" "$dst"
  done
}

install_dotfiles
