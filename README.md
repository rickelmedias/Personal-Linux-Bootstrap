# Configuração do Ubuntu 24.04 para Desenvolvimento

Este documento é um guia para configurar um ambiente de desenvolvimento no Ubuntu 24.04, incluindo ferramentas essenciais, Docker, Conda e drivers AMD (ROCm) para PyTorch.

## 1. Atualização do Sistema e Pacotes Essenciais

Primeiro, atualize os pacotes do sistema e instale as ferramentas de desenvolvimento essenciais.

```bash
sudo apt update
sudo apt upgrade -y
sudo apt install -y build-essential curl wget git unzip zip libgl1-mesa-glx zsh neovim
```

**Descrição dos Pacotes:**
- `build-essential`: Pacotes básicos para compilação (make, g++, gcc)
- `curl`, `wget`: Ferramentas de linha de comando para baixar arquivos da web
- `git`: Sistema de controle de versão
- `unzip`, `zip`: Utilitários para compactar e descompactar arquivos .zip
- `libgl1-mesa-glx`: Bibliotecas gráficas OpenGL essenciais para muitas aplicações GUI
- `zsh`: Shell avançado (será configurado na próxima etapa)

## 2. Configuração do ZSH + Oh My ZSH e Powerlevel10k

O ZSH é um shell poderoso e altamente customizável que melhora significativamente a experiência no terminal.

### 2.1. Configuração do ZSH como Shell Padrão

Agora que o ZSH está instalado, vamos configurá-lo como shell padrão.

```bash
# Define o ZSH como shell padrão
chsh -s $(which zsh)
```

**Importante:** Após executar este comando, faça logout e login novamente (ou reinicie o terminal) para que a mudança tenha efeito.

Verifique se o ZSH está rodando corretamente:

```bash
exec zsh
```

### 2.2. Instalação do Oh My ZSH

O Oh My ZSH é um framework para gerenciar a configuração do ZSH com temas e plugins.

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 2.3. Instalação de Plugins Úteis

Instale plugins que melhoram a experiência de uso do terminal:

```bash
# Autosugestões baseadas no histórico de comandos
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# Syntax highlighting para comandos
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
```

Agora, edite o arquivo `~/.zshrc` para ativar os plugins:

```bash
# Use sed para atualizar automaticamente
sed -i 's/plugins=(git)/plugins=(git sudo history zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc
```

Ou se preferir editar manualmente, procure a linha `plugins=` e altere para:

```bash
# Abra o arquivo com seu editor preferido (vim, nano, etc.)
vim ~/.zshrc
```

```bash
# Procure por plugins=() e inclua:
plugins=(
  git
  sudo
  history
  zsh-autosuggestions
  zsh-syntax-highlighting
)
```

Aplique as alterações:

```bash
source ~/.zshrc
```
### 2.4. Instalação das Fontes MesloLGS NF

> **⚠️ IMPORTANTE:** Instale e configure as fontes **ANTES** de configurar o Powerlevel10k para que os símbolos sejam exibidos corretamente.

```bash
# Cria o diretório de fontes do usuário
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts

# Baixa as fontes
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

# Atualiza o cache de fontes
fc-cache -fv
```

Agora, **configure seu terminal para usar a fonte MesloLGS NF**:

**No GNOME Terminal:**
1. Abra o menu Hamburger (três linhas horizontais) → **Preferências**
2. Selecione seu perfil (geralmente "Padrão" ou "Unnamed")
3. Vá em **Texto**
4. Ative **Fonte personalizada**
5. Clique no botão de seleção de fonte e escolha **"MesloLGS NF Regular"** (tamanho 11 ou 12 é recomendado)
6. Feche as preferências

> **⚠️ IMPORTANTE:** Feche e reabra seu terminal para que a fonte seja carregada corretamente antes de prosseguir.

### 2.5. Instalação do Tema Powerlevel10k

O Powerlevel10k é um tema moderno e rápido para o ZSH.

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
```

Altere o tema no arquivo `~/.zshrc`:

```bash
# Com sed
sed -i 's/ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

# Ou edite manualmente
vim ~/.zshrc
# Procure por ZSH_THEME e altere para: ZSH_THEME="powerlevel10k/powerlevel10k"
```

Aplique as alterações e execute o configurador:

```bash
source ~/.zshrc
```

O assistente de configuração do Powerlevel10k será iniciado automaticamente. Use as seguintes configurações recomendadas:

- **Prompt Style:** Lean
- **Character Set:** Unicode
- **Prompt Colors:** 256 colors
- **Show current time:** 12 hours
- **Prompt Height:** Two lines
- **Prompt Connection:** Dotted
- **Prompt Framw:** No Frame
- **Connection Color:** Dark
- **Prompt Spacing:** Sparse
- **Icons:** Many Colors
- **Prompt Flow:** Concise
- **Enable Transient Prompt:** No
- **Instant Prompt Mode:** Verbose
- **Apply changes to ~/.zshrc:** Yes

O comando `chsh` só altera o shell para futuras sessões de login, para persistir as mudanças e o `zsh` já aparecer ao abrir o terminal `CTRL + ALT + T`, você precisa fazer logout e login novamente no seu sistema Ubuntu ou então um simples reboot.

### 2.6. Reconfiguração (Opcional)

Se precisar reconfigurar o Powerlevel10k no futuro, execute:

```bash
p10k configure
```

### 2.7. Escolhendo a cor de Monokai Pro (Opcional)

Rode o comando abaixo, escolha 224, abra nos três pontinhos em cima do Gnome-Terminal, escolha Preferences apague a sua configuração antiga e escolha a configuração o Monkai Pro, se tiver algum conflito misturando as duas aparências, refaça o processo.

```bash
bash -c "$(wget -qO- https://git.io/vQgMr)"
```

## 3. Instalação do Miniconda (Gerenciador de Ambientes Python)

**Link oficial:** https://www.anaconda.com/docs/getting-started/miniconda/install#linux-terminal-installer

### 3.1. Download e Instalação

```bash
# Baixa o instalador
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

# Executa o instalador
bash ./Miniconda3-latest-Linux-x86_64.sh
```

### 3.2. Passos da Instalação (Interativo)

Siga os passos no terminal:

1. Pressione **Enter** para continuar
2. Após ler os termos, digite `yes` e pressione **Enter**
3. Pressione **Enter** novamente para aceitar o local de instalação padrão
4. Ao final, digite `yes` para inicializar o conda init

```
Preparing transaction: done
Executing transaction: done
installation finished.
Do you wish to update your shell profile to automatically initialize conda?
This will activate conda on startup and change the command prompt when activated.
If you'd prefer that conda's base environment not be activated on startup,
    run the following command when conda is activated:

conda config --set auto_activate_base false

You can undo this by running `conda init --reverse $SHELL`? [yes|no]
[no] >>> yes
```

**Após a instalação, feche e reabra seu terminal** para que as alterações tenham efeito.

**Se o conda não estiver ativo no zsh** tente usar `bash`, se ele estiver ativo no bash, entaõ rode o comando `conda init zsh`.

## 4. Instalação do Docker

**Link oficial:** https://docs.docker.com/engine/install/ubuntu/

### 4.1. Remover Pacotes Conflitantes

Execute o comando para desinstalar pacotes antigos ou conflitantes.

```bash
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
```

### 4.2. Configurar o Repositório APT do Docker

```bash
# Atualiza o apt e instala pré-requisitos
sudo apt-get update
sudo apt-get install ca-certificates curl

# Adiciona a chave GPG oficial do Docker
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Adiciona o repositório às fontes do Apt
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Atualiza a lista de pacotes
sudo apt-get update
```

### 4.3. Instalar o Docker Engine

```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

### 4.4. Pós-instalação (Grupo Docker)

Adicione seu usuário ao grupo docker para executar comandos do Docker sem sudo.

```bash
sudo usermod -aG docker $USER
```

**Importante:** Você precisará reiniciar o sistema (reboot) ou fazer logout/login para que essa alteração de grupo entre em vigor.

## 5. Configuração AMD GPU (ROCm e Drivers)

**Link oficial:** https://rocm.docs.amd.com/projects/install-on-linux/en/latest/install/quick-start.html

Esta seção cobre a instalação dos drivers da AMD (AMDGPU) e da plataforma ROCm para computação em GPU.

### 5.1. Instalar Drivers AMDGPU

```bash
# Baixa o pacote de instalação do repositório AMD
wget https://repo.radeon.com/amdgpu-install/7.1/ubuntu/noble/amdgpu-install_7.1.70100-1_all.deb

# Instala o pacote .deb que configura o repositório
sudo apt install ./amdgpu-install_7.1.70100-1_all.deb

# Atualiza as fontes do apt
sudo apt update

# Instala os pacotes de kernel necessários para o DKMS
sudo apt install "linux-headers-$(uname -r)" "linux-modules-extra-$(uname -r)"

# Instala o driver DKMS
sudo apt install amdgpu-dkms
```

### 5.2. Instalar ROCm (Plataforma de Computação)

```bash
# Baixa o pacote de instalação do repositório AMD (se ainda não baixou)
wget https://repo.radeon.com/amdgpu-install/7.1/ubuntu/noble/amdgpu-install_7.1.70100-1_all.deb

# Instala o pacote .deb que configura o repositório
sudo apt install ./amdgpu-install_7.1.70100-1_all.deb

# Atualiza as fontes do apt
sudo apt update

# Instala dependências Python necessárias
sudo apt install python3-setuptools python3-wheel

# Adiciona seu usuário aos grupos corretos (MUITO IMPORTANTE)
sudo usermod -a -G render,video $LOGNAME

# Instala o ROCm
sudo apt install rocm
```

**Importante:** Após instalar os drivers e o ROCm, será necessário reiniciar o sistema para carregar os módulos do kernel.

### 5.3. Instalar PyTorch para ROCm (AMD RX 7800XT)

**Link de referência:** https://rocm.docs.amd.com/projects/radeon/en/latest/docs/install/wsl/install-pytorch.html

Recomenda-se criar um ambiente conda antes de executar os passos abaixo:

```bash
conda create -n rocm-env python=3.10
conda activate rocm-env
```

Crie um diretório para os pacotes e faça o download dos arquivos .whl:

```bash
cd ~/rocm-wheels

wget https://repo.radeon.com/rocm/manylinux/rocm-rel-7.0.2/torch-2.5.1%2Brocm7.0.2.git07354c51-cp310-cp310-linux_x86_64.whl
wget https://repo.radeon.com/rocm/manylinux/rocm-rel-7.0.2/torchvision-0.22.1%2Brocm7.0.2.git59a3e1f9-cp310-cp310-linux_x86_64.whl
wget https://repo.radeon.com/rocm/manylinux/rocm-rel-7.0.2/torchaudio-2.7.1%2Brocm7.0.2.git95c61b41-cp310-cp310-linux_x86_64.whl
wget https://repo.radeon.com/rocm/manylinux/rocm-rel-7.0.2/triton-3.1.0%2Brocm7.0.2.git1e26fcf7-cp310-cp310-linux_x86_64.whl
```
Após o download, garanta que nenhuma versão anterior está instalada:

```bash
python -m pip uninstall -y torch torchvision torchaudio pytorch-triton-rocm
```

Finalmente, instale as bibliotecas a partir dos arquivos .whl:

```bash
python -m pip install \
  ./torch-2.5.1+rocm7.0.2.git07354c51-cp310-cp310-linux_x86_64.whl \
  ./torchvision-0.22.1+rocm7.0.2.git59a3e1f9-cp310-cp310-linux_x86_64.whl \
  ./torchaudio-2.7.1+rocm7.0.2.git95c61b41-cp310-cp310-linux_x86_64.whl \ 
  ./triton-3.1.0+rocm7.0.2.git1e26fcf7-cp310-cp310-linux_x86_64.whl
```

### 5.4. Verificar Instalação do PyTorch

Execute os seguintes comandos no terminal para validar a instalação:

```bash
# Validação básica de importação
# Saída esperada: Sucesso
python3 -c 'import torch' 2> /dev/null && echo 'Sucesso' || echo 'Falha'


# Testar se a GPU (ROCm) está disponível
# (torch.cuda.is_available() é usado mesmo sendo AMD, pois o PyTorch abstrai isso)
# Saída esperada: True

python3 -c 'import torch; print(torch.cuda.is_available())'

# Exibir o nome da GPU
# Saída esperada (exemplo): device name [0]: AMD Radeon RX 7800 XT
python3 -c "import torch; print(f'device name [0]:', torch.cuda.get_device_name(0))"
```

### 5.5. Instalar TensorFlow para ROCm

**Link de referência:** https://rocm.docs.amd.com/projects/radeon/en/latest/docs/install/native_linux/install-tensorflow.html

Primeiro, baixe o arquivo .whl (no mesmo diretório rocm-wheels):

```bash
cd ~/rocm-wheels

wget https://repo.radeon.com/rocm/manylinux/rocm-rel-7.0.2/tensorflow_rocm-2.18.1-cp310-cp310-manylinux_2_28_x86_64.whl
```

Certifique-se de selecionar o seu conda environment. Nesse caso será instalado ao `conda activate rocm-env`.

Garantir que não existem bibliotecas anteriores do tensorflow.

```bash
python -m pip uninstall -y tensorflow tensorflow-cpu tensorflow-rocm tensorflow-gpu || true
```

E instalar o Tensorflow.

```bash
python -m pip install ./tensorflow_rocm-2.18.1-cp310-cp310-manylinux_2_28_x86_64.whl
```


### 5.6. Verificar Instalação do TensorFlow

Execute os seguintes comandos para validar:

```bash
# Validação básica de importação
# Saída esperada: Sucesso
python3 -c 'import tensorflow' 2> /dev/null && echo 'Sucesso' || echo 'Falha'
```

**Se ao rodar o comando acima ele falhar** você pode tentar trocar a versão do Tensorflow seguindo a documentação, ou seja, lembre que essa documentação atual é viva, por esse motivo foi adicionado as fontes oficiais.

Execute um exemplo básico do TensorFlow:

```py
import tensorflow as tf
print("TensorFlow version:", tf.__version__)
mnist = tf.keras.datasets.mnist

(x_train, y_train), (x_test, y_test) = mnist.load_data()
x_train, x_test = x_train / 255.0, x_test / 255.0
model = tf.keras.models.Sequential([
  tf.keras.layers.Flatten(input_shape=(28, 28)),
  tf.keras.layers.Dense(128, activation='relu'),
  tf.keras.layers.Dropout(0.2),
  tf.keras.layers.Dense(10)
])
predictions = model(x_train[:1]).numpy()
tf.nn.softmax(predictions).numpy()
loss_fn = tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True)
loss_fn(y_train[:1], predictions).numpy()
model.compile(optimizer='adam',
              loss=loss_fn,
              metrics=['accuracy'])
model.fit(x_train, y_train, epochs=5)
model.evaluate(x_test,  y_test, verbose=2)
```

Durante a execução, você verá logs indicando a GPU sendo usada:

```
I0000 00:00:1757470660.827850    7847 gpu_device.cc:2022] Created device /job:localhost/replica:0/task:0/device:GPU:0 with 14643 MB memory:  -> device: 0, name: AMD Radeon RX 7800 XT, pci bus id: 0000:03:00.0
Epoch 1/5
...
```

## 6. Instalação de Linguagens de Programação com Mise

**Link oficial:** https://mise.jdx.dev/getting-started.html

O mise é um gerenciador de versões de ferramentas (como nvm ou sdkman, mas para várias linguagens) que permite definir versões globais ou por projeto.

Para instalá-lo:

```bash
curl https://mise.run | sh
```

Após instalar, configure-o para o seu shell (zsh).

```bash
echo 'eval "$(~/.local/bin/mise activate zsh)"' >> "$HOME/.zshrc"
```

Recarregue seu shell e verifique a instalação:

```bash
# Recarrega o shell
exec zsh

# Verifica a instalação do mise
mise doctor
# Saída esperada ao final: No problems found

# Verifica a versão
~/.local/bin/mise --version
```

### 6.1. Instalando Linguagens (Java, Rust, Node, Go, Maven)

```bash
mise install java@temurin-21 rust@latest node@lts go@latest maven@latest
```

Após instalar, defina-as como globais:

```bash
mise use --global java@temurin-21 rust@latest node@lts go@latest maven@latest -v
```

### 6.2. Verificação das Linguagens

Recarregue o shell novamente e verifique as versões:

```bash
# Recarrega o shell
exec zsh

# Verifica o mise e as linguagens instaladas
mise doctor

mvn -v
java -version
node -v
go version
rustc --version
```

## 7. Configuração do Git e SSH

O Git já foi instalado na Seção 1, mas agora vamos configurá-lo corretamente com sua identidade e chaves SSH para autenticação segura com serviços como o GitHub.

### 7.1. Autenticação com Chave SSH

**Link oficial:** https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

Este comando gera um par de chaves criptográficas (uma pública e uma privada) que são usadas para autenticação.

```bash
# Gera uma nova chave Ed25519 (algoritmo moderno e seguro)
ssh-keygen -t ed25519 -C "seu_email@example.com"
```

- `t ed25519`: Especifica o tipo de chave (moderno e recomendado);
- `C "..."`: Adiciona um comentário à chave, geralmente seu e-mail, para fácil identificação.

Após executar o comando, copie sua chave pública para o GitHub:

```bash
# Exibe a chave pública no terminal para você copiar
cat ~/.ssh/id_ed25519.pub
```

Acesse as configurações do seu GitHub, vá em "SSH and GPG keys" e cole o conteúdo exibido.

> **⚠️ IMPORTANTE:** Vale ressaltar que você nunca deve compartilhar sua chave `id_ed25519` privada.

### 7.2. Configurações Globais do Git

Estes comandos definem sua identidade para todos os repositórios em sua máquina.

```bash
# Define seu nome de usuário (que aparecerá nos commits)
git config --global user.name "Seu Nome"

# Define seu e-mail (que será vinculado aos seus commits no GitHub)
git config --global user.email "seu@email.com"

# Define o nome da branch padrão para "main"
git config --global init.defaultBranch main

# Define a estratégia do "git pull" como "merge" (padrão)
git config --global pull.rebase false

# Define o editor de texto padrão do Git (ex: Neovim)
git config --global core.editor "nvim -c 'startinsert'"

# Configura como o Git lida com quebras de linha (essencial para Linux)
git config --global core.autocrlf input
```

Explicação das Configurações:

- `user.name` e `user.email`: Sua identidade. O e-mail deve ser o mesmo cadastrado no GitHub para que os commits sejam associados ao seu perfil.

- `init.defaultBranch main`: Garante que novos repositórios criados com `git init` usem "main" como a branch principal, em vez do antigo "master".

- `pull.rebase false`: Configura `git pull` para usar a estratégia de merge (padrão) em vez de rebase. Isso cria um commit de merge, o que é mais explícito e seguro para iniciantes.

- `core.editor`: Define qual editor abrir quando o Git precisar de uma mensagem longa (ex: `git commit`). O exemplo usa Neovim (`nvim`) já entrando em modo de inserção.

- `core.autocrlf input`: Configuração crucial para evitar problemas de quebra de linha entre sistemas operacionais. `input` garante que o Git converta quebras de linha do Windows (CRLF) para o padrão do Linux (LF) ao salvar no repositório.

### 7.3. Diffs Mais Bonitos com delta (Opcional)
`delta` é uma ferramenta que torna os `diffs` (comparações) do Git muito mais legíveis.

```bash
# Instala o git-delta
sudo apt install -y git-delta

# Configura o Git para usar o 'delta' para diffs
git config --global pager.diff delta

# Configura o Git para usar o 'delta' para logs
git config --global pager.log delta

# Habilita o 'delta' para o modo interativo (ex: git add -p)
git config --global interactive.diffFilter "delta --color-only"
```

Esses comandos dizem ao Git para, em vez de mostrar o `diff` padrão, enviar a saída para o `delta`, que irá formatá-la com cores, destaques e uma visualização melhor.

## 8. Personalização do NeoVim

Copie o `~/.config/nvim`, execute o `nvim filesample.txt` e rode o comando para baixar os pacotes `:PackerSync`.

## 9. Personalização da Interface (GNOME)

Esta etapa é opcional e foca na personalização visual do ambiente GNOME.

### 9.1. Instalar Ferramentas

Instale o Gerenciador de Extensões (para gerenciar extensões) e o GNOME Tweaks (Ajustes, para temas).

```bash
sudo apt install gnome-tweaks gnome-shell-extension-manager
```

### 9.2. Configurações de Tema e Ícones (Exemplo)

Estes são os temas e ícones mencionados na sua configuração:

- **Tema (Legacy App / Shell):** WhiteSur Dark (ou WhiteSur Dark Green)
- **Cursor:** Whiteglass
- **Ícones:** Yaru bark dark

Você pode baixar temas e ícones de sites como [GNOME-Look.org](https://www.gnome-look.org) e instalá-los em `~/.themes` e `~/.icons`, respectivamente. Depois, ative-os usando o aplicativo GNOME Tweaks (Ajustes).

### 9.3. Extensões GNOME

Use o aplicativo Extension Manager (Gerenciador de Extensões) para procurar e instalar:

- **Dash to Dock**
- **User Themes** (Necessário para aplicar temas de shell baixados)

Ao instalar a Dash to Dock **se você tiver problema de aparecer duas docks ao mesmo tempo** basta entrar no Gerenciador de Extensões e desativar a Dock Ubuntu, se der alguma instabilidade ou travamento gráfico, é só fazer Log Out ou Reboot.

## 10. Personalização do GRUB (Opcional)

Para estilizar o menu de boot do GRUB (onde você escolhe entre Ubuntu e Windows 11).

```bash
# Clona o repositório de temas
git clone https://github.com/vinceliuice/grub2-themes.git

# Entra no diretório
cd grub2-themes

# Executa o script de instalação (requer sudo)
# Você será solicitado a escolher um tema e opções
sudo ./install.sh
```

## 11. Reinicialização Final

Após todas as instalações (especialmente Docker e os drivers AMDGPU/ROCm), reinicie o sistema para que todas as alterações, módulos de kernel e permissões de grupo sejam aplicados.

```bash
sudo reboot
```
