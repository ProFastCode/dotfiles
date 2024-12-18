# Установка пакетов через Chocolatey
choco install fd fzf exa kitty neovim nodejs ripgrep -y

# Функция для копирования файла с переименованием существующего
function Copy-WithRename {
  param (
    [string]$sourceFile,
    [string]$targetFile
  )

  if (Test-Path $targetFile) {
    # Получаем имя файла без пути
    $targetFilename = [System.IO.Path]::GetFileName($targetFile)
    # Получаем путь к директории, где находится целевой файл
    $targetDir = [System.IO.Path]::GetDirectoryName($targetFile)
    # Генерируем новое имя для существующего файла
    $newTargetFile = Join-Path $targetDir "${targetFilename.Split('.')[0]}_old.${targetFilename.Split('.')[-1]}"

    # Проверяем, существует ли уже файл с таким именем
    if (Test-Path $newTargetFile) {
      Write-Host "Файл с именем $newTargetFile уже существует. Переименование невозможно."
      return
    }

    # Переименовываем существующий файл
    Move-Item $targetFile $newTargetFile
    Write-Host "Файл $targetFile переименован в $newTargetFile"
  }

  # Копируем исходный файл в целевой файл
  Copy-Item $sourceFile $targetFile
  Write-Host "Файл $sourceFile скопирован в $targetFile"
}

# Копирование .zshrc
Copy-WithRename ".zshrc" "$HOME\.zshrc"

# Копирование .ruff.toml
Copy-WithRename ".ruff.toml" "$HOME\.ruff.toml"

# Копирование директории .oh-my-zsh
if (Test-Path "$HOME\.oh-my-zsh") {
  $newTargetDir = "$HOME\.oh-my-zsh_old"
  if (Test-Path $newTargetDir) {
    Write-Host "Директория с именем $newTargetDir уже существует. Переименование невозможно."
  } else {
    Move-Item "$HOME\.oh-my-zsh" $newTargetDir
    Write-Host "Директория $HOME\.oh-my-zsh переименована в $newTargetDir"
  }
}
Copy-Item -Recurse ".oh-my-zsh" "$HOME\"
Write-Host "Директория .oh-my-zsh скопирована в $HOME\"

# Копирование директории .config/kitty
if (Test-Path "$HOME\.config\kitty") {
  $newTargetDir = "$HOME\.config\kitty_old"
  if (Test-Path $newTargetDir) {
    Write-Host "Директория с именем $newTargetDir уже существует. Переименование невозможно."
  } else {
    Move-Item "$HOME\.config\kitty" $newTargetDir
    Write-Host "Директория $HOME\.config\kitty переименована в $newTargetDir"
  }
}
Copy-Item -Recurse ".config\kitty" "$HOME\.config\kitty"
Write-Host "Директория .config\kitty скопирована в $HOME\.config\kitty"

# Копирование директории .config/nvim
if (Test-Path "$HOME\.config\nvim") {
  $newTargetDir = "$HOME\.config\nvim_old"
  if (Test-Path $newTargetDir) {
    Write-Host "Директория с именем $newTargetDir уже существует. Переименование невозможно."
  } else {
    Move-Item "$HOME\.config\nvim" $newTargetDir
    Write-Host "Директория $HOME\.config\nvim переименована в $newTargetDir"
  }
}
Copy-Item -Recurse ".config\nvim" "$HOME\.config\nvim"
Write-Host "Директория .config\nvim скопирована в $HOME\.config\nvim"

# Копирование директории .config/thefuck
if (Test-Path "$HOME\.config\thefuck") {
  $newTargetDir = "$HOME\.config\thefuck_old"
  if (Test-Path $newTargetDir) {
    Write-Host "Директория с именем $newTargetDir уже существует. Переименование невозможно."
  } else {
    Move-Item "$HOME\.config\thefuck" $newTargetDir
    Write-Host "Директория $HOME\.config\thefuck переименована в $newTargetDir"
  }
}
Copy-Item -Recurse ".config\thefuck" "$HOME\.config\thefuck"
Write-Host "Директория .config\thefuck скопирована в $HOME\.config\thefuck"
