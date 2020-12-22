From: gengcixi@gmail.com <gengcixi@gmail.com>
Date: Tue, 22 Dec 2020 13:48:38 +0800
Subject: [LTP] [PATCH 1/4] delete_module: add gitignore file
In-Reply-To: <20201222054841.736529-1-gengcixi@gmail.com>
References: <20201222054841.736529-1-gengcixi@gmail.com>
Message-ID: <20201222054841.736529-2-gengcixi@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Cixi Geng <cixi.geng1@unisoc.com>

When build ltp, there have generate some module files in delete_module,
add these files into .gitignore
Untracked files:
   (Use "git add <file>..." to include the content to be submitted)
	testcases/kernel/syscalls/delete_module/.built-in.a.cmd
	testcases/kernel/syscalls/delete_module/.dummy_del_mod.ko.cmd
	testcases/kernel/syscalls/delete_module/.dummy_del_mod.mod.cmd
	testcases/kernel/syscalls/delete_module/.dummy_del_mod.mod.o.cmd
	testcases/kernel/syscalls/delete_module/.dummy_del_mod.o.cmd
	testcases/kernel/syscalls/delete_module/.dummy_del_mod_dep.ko.cmd
	testcases/kernel/syscalls/delete_module/.dummy_del_mod_dep.mod.cmd
	testcases/kernel/syscalls/delete_module/.dummy_del_mod_dep.mod.o.cmd
	testcases/kernel/syscalls/delete_module/.dummy_del_mod_dep.o.cmd
	testcases/kernel/syscalls/delete_module/Module.symvers
	testcases/kernel/syscalls/delete_module/dummy_del_mod.mod.c
	testcases/kernel/syscalls/delete_module/dummy_del_mod_dep.mod.c
	testcases/kernel/syscalls/delete_module/modules.order

Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 testcases/kernel/syscalls/delete_module/.gitignore | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/delete_module/.gitignore b/testcases/kernel/syscalls/delete_module/.gitignore
index 8ffd4256e..1a774a6d5 100644
--- a/testcases/kernel/syscalls/delete_module/.gitignore
+++ b/testcases/kernel/syscalls/delete_module/.gitignore
@@ -1,5 +1,12 @@
 /delete_module01
 /delete_module02
 /delete_module03
-/dummy_del_mod.ko
-/dummy_del_mod_dep.ko
+/*.ko
+/*.mod.c
+/*.ko.cmd
+/*.mod.cmd
+/*.mod.o.cmd
+/*.o.cmd
+/.built-in.a.cmd
+/Module.symvers
+/modules.order
-- 
2.25.1

