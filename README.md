# Configuração do Ubuntu 24.04 para Desenvolvimento

![Imagem](https://images.unsplash.com/photo-1629654297299-c8506221ca97?q=80&w=1548&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D)

Este documento é um guia para configurar um ambiente de desenvolvimento no Ubuntu 24.04, incluindo ferramentas essenciais, Docker, Conda e drivers AMD (ROCm) para PyTorch.

## 1. Atualização do Sistema e Pacotes Essenciais

Primeiro, atualize os pacotes do sistema e instale as ferramentas de desenvolvimento essenciais.
**Nota:** O pacote `libgl1-mesa-glx` foi descontinuado no Ubuntu 24.04 e substituído pelo `libgl1`. Adicionamos também ferramentas utilitárias como `git-delta` e `gnome-tweaks` nesta etapa inicial.

```bash
sudo apt update
sudo apt upgrade -y
sudo apt install -y build-essential curl wget git unzip zip libgl1 zsh neovim gnome-tweaks gnome-shell-extension-manager git-delta
```

**Descrição dos Pacotes:**
- `build-essential`: Pacotes básicos para compilação (make, g++, gcc)
- `libgl1`: Bibliotecas gráficas OpenGL (substituto moderno do mesa-glx)
- `zsh`: Shell avançado
- `gnome-tweaks` / `extension-manager`: Personalização visual
- `git-delta`: Visualizador de diffs melhorado para git

## 2. Configuração do ZSH + Oh My ZSH e Powerlevel10k

### 2.1. Configuração do ZSH como Shell Padrão

```bash
# Define o ZSH como shell padrão
chsh -s $(which zsh)
```

> **🔄 Checkpoint:** É necessário fazer **Logout e Login** agora para que o ZSH se torne seu terminal padrão.

### 2.2. Instalação do Oh My ZSH

```bash
sh -c "$(curl -fsSL [https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh](https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh))"
```

### 2.3. Instalação de Plugins Úteis

```bash
# Autosugestões
git clone [https://github.com/zsh-users/zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# Syntax highlighting
git clone [https://github.com/zsh-users/zsh-syntax-highlighting.git](https://github.com/zsh-users/zsh-syntax-highlighting.git) ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
```

Configuração automática no `.zshrc`:

```bash
sed -i 's/plugins=(git)/plugins=(git sudo history zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc
source ~/.zshrc
```

### 2.4. Instalação das Fontes MesloLGS NF

> **⚠️ IMPORTANTE:** Instale e configure as fontes **ANTES** de configurar o Powerlevel10k.

```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget [https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf)
wget [https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf)
wget [https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf)
wget [https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf)
fc-cache -fv
```

**Ação Manual:** Abra as Preferências do Terminal → Perfil Ativo → Texto → Ative "Fonte personalizada" e selecione **MesloLGS NF Regular**. Feche e reabra o terminal.

### 2.5. Instalação do Tema Powerlevel10k

```bash
git clone --depth=1 [https://github.com/romkatv/powerlevel10k.git](https://github.com/romkatv/powerlevel10k.git) ~/.oh-my-zsh/custom/themes/powerlevel10k
sed -i 's/ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
source ~/.zshrc
```

Siga o assistente de configuração (Recomendado: Lean, Unicode, 256 colors, No Frame, Sparse, Many Colors, Concise, Transient Prompt: No, Instant Prompt: Verbose).

### 2.6. Esquema de Cores (Opcional - Monokai Pro)

```bash
bash -c "$(wget -qO- [https://git.io/vQgMr](https://git.io/vQgMr))"
```
Escolha a opção **224**. Depois vá nas Preferências do Terminal > Cores e selecione o perfil criado.

## 3. Instalação do Miniconda

```bash
wget [https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh](https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh)
bash ./Miniconda3-latest-Linux-x86_64.sh
```
Responda `yes` para os termos e `yes` para o `conda init`.
**Reinicie o terminal**. Se o conda não ativar, rode `conda init zsh`.

## 4. Instalação do Docker

### 4.1. Instalação Limpa

```bash
# Remove pacotes conflitantes
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

# Configura repositório
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL [https://download.docker.com/linux/ubuntu/gpg](https://download.docker.com/linux/ubuntu/gpg) -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] [https://download.docker.com/linux/ubuntu](https://download.docker.com/linux/ubuntu) \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Instala Docker Engine
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

### 4.2. Grupo de Usuário (Permissão Docker)

```bash
sudo usermod -aG docker $USER
```

> **🔄 Checkpoint:** É **obrigatório** fazer Logout/Login (ou reiniciar) para aplicar as permissões de grupo.

## 5. Configuração AMD GPU (Drivers e ROCm)

### 5.1. Instalar Drivers e ROCm

```bash
# Baixa instalador do repositório
wget [https://repo.radeon.com/amdgpu-install/7.1/ubuntu/noble/amdgpu-install_7.1.70100-1_all.deb](https://repo.radeon.com/amdgpu-install/7.1/ubuntu/noble/amdgpu-install_7.1.70100-1_all.deb)
sudo apt install ./amdgpu-install_7.1.70100-1_all.deb
sudo apt update

# Headers do kernel e dependências
sudo apt install "linux-headers-$(uname -r)" "linux-modules-extra-$(uname -r)" python3-setuptools python3-wheel

# Instala Driver (DKMS) e ROCm
sudo apt install amdgpu-dkms rocm
```

### 5.2. Permissões de Grupo (Render/Video)

```bash
sudo usermod -a -G render,video $LOGNAME
```

> **🔄 Checkpoint Crítico:** Reinicie o computador (`sudo reboot`) agora para carregar os módulos do kernel AMD e permissões de vídeo.

### 5.3. Instalar PyTorch com ROCm (Após Reboot)

**Opção A: Python 3.10 (Estável)**

```bash
conda create -n rocm-env python=3.10 && conda activate rocm-env
mkdir -p ~/rocm-wheels/310 && cd ~/rocm-wheels/310

wget [https://repo.radeon.com/rocm/manylinux/rocm-rel-7.0.2/torch-2.5.1%2Brocm7.0.2.git07354c51-cp310-cp310-linux_x86_64.whl](https://repo.radeon.com/rocm/manylinux/rocm-rel-7.0.2/torch-2.5.1%2Brocm7.0.2.git07354c51-cp310-cp310-linux_x86_64.whl)
wget [https://repo.radeon.com/rocm/manylinux/rocm-rel-7.0.2/torchvision-0.22.1%2Brocm7.0.2.git59a3e1f9-cp310-cp310-linux_x86_64.whl](https://repo.radeon.com/rocm/manylinux/rocm-rel-7.0.2/torchvision-0.22.1%2Brocm7.0.2.git59a3e1f9-cp310-cp310-linux_x86_64.whl)
wget [https://repo.radeon.com/rocm/manylinux/rocm-rel-7.0.2/torchaudio-2.7.1%2Brocm7.0.2.git95c61b41-cp310-cp310-linux_x86_64.whl](https://repo.radeon.com/rocm/manylinux/rocm-rel-7.0.2/torchaudio-2.7.1%2Brocm7.0.2.git95c61b41-cp310-cp310-linux_x86_64.whl)
wget [https://repo.radeon.com/rocm/manylinux/rocm-rel-7.0.2/triton-3.1.0%2Brocm7.0.2.git1e26fcf7-cp310-cp310-linux_x86_64.whl](https://repo.radeon.com/rocm/manylinux/rocm-rel-7.0.2/triton-3.1.0%2Brocm7.0.2.git1e26fcf7-cp310-cp310-linux_x86_64.whl)

pip uninstall -y torch torchvision torchaudio pytorch-triton-rocm
pip install torch-2.5.1*.whl torchvision-0.22.1*.whl torchaudio-2.7.1*.whl triton-3.1.0*.whl
```

**Opção B: Python 3.11 (Experimental/YoloV5)**

```bash
conda create -n rocm-env-311 python=3.11 && conda activate rocm-env-311
mkdir -p ~/rocm-wheels/311 && cd ~/rocm-wheels/311

wget [https://repo.radeon.com/rocm/manylinux/rocm-rel-7.0.2/torch-2.7.1%2Brocm7.0.2.git9015dfdf-cp311-cp311-linux_x86_64.whl](https://repo.radeon.com/rocm/manylinux/rocm-rel-7.0.2/torch-2.7.1%2Brocm7.0.2.git9015dfdf-cp311-cp311-linux_x86_64.whl)
wget [https://repo.radeon.com/rocm/manylinux/rocm-rel-7.0.2/torchvision-0.23.0%2Brocm7.0.2.git824e8c87-cp311-cp311-linux_x86_64.whl](https://repo.radeon.com/rocm/manylinux/rocm-rel-7.0.2/torchvision-0.23.0%2Brocm7.0.2.git824e8c87-cp311-cp311-linux_x86_64.whl)
wget [https://repo.radeon.com/rocm/manylinux/rocm-rel-7.0.2/torchaudio-2.7.1%2Brocm7.0.2.git95c61b41-cp311-cp311-linux_x86_64.whl](https://repo.radeon.com/rocm/manylinux/rocm-rel-7.0.2/torchaudio-2.7.1%2Brocm7.0.2.git95c61b41-cp311-cp311-linux_x86_64.whl)
wget [https://repo.radeon.com/rocm/manylinux/rocm-rel-7.0.2/triton-3.3.1%2Brocm7.0.2.git9c7bc0a3-cp311-cp311-linux_x86_64.whl](https://repo.radeon.com/rocm/manylinux/rocm-rel-7.0.2/triton-3.3.1%2Brocm7.0.2.git9c7bc0a3-cp311-cp311-linux_x86_64.whl)

pip install torch-2.7.1*.whl torchvision-0.23.0*.whl torchaudio-2.7.1*.whl triton-3.3.1*.whl
```

## 6. Instalação de Linguagens com Mise

```bash
# Instalação do Mise
curl [https://mise.run](https://mise.run) | sh
echo 'eval "$(~/.local/bin/mise activate zsh)"' >> "$HOME/.zshrc"
exec zsh
```

### 6.1. Configurando Plugins e Instalando Linguagens

Para evitar erros no Maven (registro Aqua), adicionamos o plugin oficial primeiro.

```bash
# 1. Adiciona o plugin oficial do Maven
mise plugin add maven

# 2. Instala as linguagens
mise install java@temurin-21 rust@latest node@lts go@latest maven@latest

# 3. Define como global
mise use --global java@temurin-21 rust@latest node@lts go@latest maven@latest
```

Verifique com `mise doctor`.

## 7. Configuração do Git e SSH

### 7.1. SSH

```bash
ssh-keygen -t ed25519 -C "seu_email@example.com"
cat ~/.ssh/id_ed25519.pub
```
Copie a chave e adicione no GitHub.

### 7.2. Configurações Globais

```bash
git config --global user.name "Seu Nome"
git config --global user.email "seu@email.com"
git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global core.editor "nvim -c 'startinsert'"
git config --global core.autocrlf input

# Configuração do Delta (Diffs bonitos)
git config --global pager.diff delta
git config --global pager.log delta
git config --global interactive.diffFilter "delta --color-only"
```

## 8. Personalização da Interface (GNOME)

Como já instalamos os pacotes na Seção 1, siga apenas a configuração:

1.  **Baixar:** Temas (ex: WhiteSur) e Ícones (ex: Yaru bark dark) no [GNOME-look](https://www.gnome-look.org). Mova para `~/.themes` e `~/.icons`.
2.  **Ativar:** Abra o **Ajustes (GNOME Tweaks)** > Aparência.
3.  **Extensões:** Abra o **Gerenciador de Extensões** e instale "Dash to Dock" e "User Themes".

## 9. Finalização

Se todos os passos foram seguidos, seu ambiente está pronto. Caso não tenha reiniciado anteriormente:

```bash
sudo reboot
```
