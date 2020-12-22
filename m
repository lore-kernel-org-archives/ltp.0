From: gengcixi@gmail.com <gengcixi@gmail.com>
Date: Tue, 22 Dec 2020 13:48:39 +0800
Subject: [LTP] [PATCH 2/4] init_module: add gitignore file
In-Reply-To: <20201222054841.736529-1-gengcixi@gmail.com>
References: <20201222054841.736529-1-gengcixi@gmail.com>
Message-ID: <20201222054841.736529-3-gengcixi@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Cixi Geng <cixi.geng1@unisoc.com>

When build ltp, there have generate some module files in init_module,
add these files into .gitignore
Untracked files:
   (Use "git add <file>..." to include the content to be submitted)
	testcases/kernel/syscalls/init_module/.built-in.a.cmd
	testcases/kernel/syscalls/init_module/.init_module.ko.cmd
	testcases/kernel/syscalls/init_module/.init_module.mod.cmd
	testcases/kernel/syscalls/init_module/.init_module.mod.o.cmd
	testcases/kernel/syscalls/init_module/.init_module.o.cmd
	testcases/kernel/syscalls/init_module/Module.symvers
	testcases/kernel/syscalls/init_module/init_module.mod.c
	testcases/kernel/syscalls/init_module/modules.order

Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 testcases/kernel/syscalls/init_module/.gitignore | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/testcases/kernel/syscalls/init_module/.gitignore b/testcases/kernel/syscalls/init_module/.gitignore
index b4d11e958..23baeb651 100644
--- a/testcases/kernel/syscalls/init_module/.gitignore
+++ b/testcases/kernel/syscalls/init_module/.gitignore
@@ -1,3 +1,11 @@
 /init_module01
 /init_module02
 /*.ko
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

