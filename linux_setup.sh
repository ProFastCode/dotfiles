#!/bin/bash

# Установка пакетов через apt (Ubuntu/Debian)
sudo apt update
sudo apt install -y fd-find fzf exa kitty neovim nodejs ripgrep

# Функция для копирования файла с переименованием существующего
copy_with_rename() {
  local source_file="$1"
  local target_file="$2"

  if [ -e "$target_file" ]; then
    # Получаем имя файла без пути
    target_filename=$(basename "$target_file")
    # Получаем путь к директории, где находится целевой файл
    target_dir=$(dirname "$target_file")
    # Генерируем новое имя для существующего файла
    new_target_file="${target_dir}/${target_filename%.*}_old.${target_filename##*.}"

    # Проверяем, существует ли уже файл с таким именем
    if [ -e "$new_target_file" ]; then
      echo "Файл с именем $new_target_file уже существует. Переименование невозможно."
      return 1
    fi

    # Переименовываем существующий файл
    mv "$target_file" "$new_target_file"
    echo "Файл $target_file переименован в $new_target_file"
  fi

  # Копируем исходный файл в целевой файл
  cp "$source_file" "$target_file"
  echo "Файл $source_file скопирован в $target_file"
}

# Копирование .bashrc
copy_with_rename ".bashrc" "$HOME/.bashrc"

# Копирование .ruff.toml
copy_with_rename ".ruff.toml" "$HOME/.ruff.toml"

# Копирование директории .oh-my-zsh
if [ -d "$HOME/.oh-my-zsh" ]; then
  new_target_dir="$HOME/.oh-my-zsh_old"
  if [ -d "$new_target_dir" ]; then
    echo "Директория с именем $new_target_dir уже существует. Переименование невозможно."
  else
    mv "$HOME/.oh-my-zsh" "$new_target_dir"
    echo "Директория $HOME/.oh-my-zsh переименована в $new_target_dir"
  fi
fi
cp -R ".oh-my-zsh" "$HOME/"
echo "Директория .oh-my-zsh скопирована в $HOME/"

# Копирование директории .config/kitty
if [ -d "$HOME/.config/kitty" ]; then
  new_target_dir="$HOME/.config/kitty_old"
  if [ -d "$new_target_dir" ]; then
    echo "Директория с именем $new_target_dir уже существует. Переименование невозможно."
  else
    mv "$HOME/.config/kitty" "$new_target_dir"
    echo "Директория $HOME/.config/kitty переименована в $new_target_dir"
  fi
fi
cp -R ".config/kitty" "$HOME/.config/kitty"
echo "Директория .config/kitty скопирована в $HOME/.config/kitty"

# Копирование директории .config/nvim
if [ -d "$HOME/.config/nvim" ]; then
  new_target_dir="$HOME/.config/nvim_old"
  if [ -d "$new_target_dir" ]; then
    echo "Директория с именем $new_target_dir уже существует. Переименование невозможно."
  else
    mv "$HOME/.config/nvim" "$new_target_dir"
    echo "Директория $HOME/.config/nvim переименована в $new_target_dir"
  fi
fi
cp -R ".config/nvim" "$HOME/.config/nvim"
echo "Директория .config/nvim скопирована в $HOME/.config/nvim"

# Копирование директории .config/thefuck
if [ -d "$HOME/.config/thefuck" ]; then
  new_target_dir="$HOME/.config/thefuck_old"
  if [ -d "$new_target_dir" ]; then
    echo "Директория с именем $new_target_dir уже существует. Переименование невозможно."
  else
    mv "$HOME/.config/thefuck" "$new_target_dir"
    echo "Директория $HOME/.config/thefuck переименована в $new_target_dir"
  fi
fi
cp -R ".config/thefuck" "$HOME/.config/thefuck"
echo "Директория .config/thefuck скопирована в $HOME/.config/thefuck"
