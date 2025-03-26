#!/usr/bin/env sh

include="bash brew-aliases config ssh stack vim bash_profile bashrc gemrc ghci iex.exs inputrc"
cutstring="DO NOT EDIT BELOW THIS LINE"

for name in $include; do
  target="$HOME/.$name"

  # If the target exists...
  if [ -e "$target" ]; then
    # ... and it's not a symlink...
    if [ ! -L "$target" ]; then
      # ... find the cutstring in the target.
      linesabove=$(grep -m 1 -n "$cutstring" "$target" | sed "s/:.*//")
      # If we found the cutstring...
      if [ -n "$linesabove" ]; then
        echo "Updating $target"
        # ... copy it and the lines above it to a temp file.
        tmp=$(mktemp)
        head -n "$linesabove" "$target" >"$tmp"
        # Then find the cutstring in the (reversed) source.
        linesbelow=$(sed '1!G;h;$!d' "$name" | grep -m 1 -n "$cutstring" | sed "s/:.*//")
        # If we found the cutstring, append the lines below it to the temp file.
        if [ -n "$linesbelow" ]; then
          tail -n "$((linesbelow - 1))" "$name" >>"$tmp"
        # If we didn't find the cutstring, append the whole file to the temp file.
        else
          cat "$name" >>"$tmp"
        fi
        # Finally, move the temp file to the target destination.
        mv "$tmp" "$target"
      # If we didn't find the cutstring in the target, show a warning and do nothing.
      else
        echo "WARNING: $target exists but is not a symlink"
      fi
    fi
  # If the target doesn't exist...
  else
    echo "Creating $target"
    # ... if it contains the cutstring, copy it.
    if grep -q "$cutstring" "$name"; then
      cp "$PWD/$name" "$target"
    # ... if it doesn't contain the cutstring, symlink it.
    else
      ln -s "$PWD/$name" "$target"
    fi
  fi
done
