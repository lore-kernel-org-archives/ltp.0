From: gengcixi@gmail.com <gengcixi@gmail.com>
Date: Tue, 22 Dec 2020 13:48:37 +0800
Subject: [LTP] [PATCH 0/4] add compiled_module_files into gitignore
Message-ID: <20201222054841.736529-1-gengcixi@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Cixi Geng <cixi.geng1@unisoc.com>

*** BLURB HERE ***
Use Out-of-build-tree build ltp, When compile kernel module 
under these directories, some module-build-file wil generated.
add these files into .gitinore

Cixi Geng (4):
  delete_module: add gitignore file
  init_module: add gitignore file
  insmod:add gitignore files
  lsmod: add gitignore files

 testcases/commands/insmod/.gitignore               |  9 +++++++++
 testcases/commands/lsmod/.gitignore                |  9 +++++++++
 testcases/kernel/syscalls/delete_module/.gitignore | 11 +++++++++--
 testcases/kernel/syscalls/init_module/.gitignore   |  8 ++++++++
 4 files changed, 35 insertions(+), 2 deletions(-)
 create mode 100644 testcases/commands/insmod/.gitignore
 create mode 100644 testcases/commands/lsmod/.gitignore

-- 
2.25.1

