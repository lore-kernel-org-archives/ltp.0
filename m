From: gengcixi@gmail.com <gengcixi@gmail.com>
Date: Tue, 22 Dec 2020 13:48:41 +0800
Subject: [LTP] [PATCH 4/4] lsmod: add gitignore files
In-Reply-To: <20201222054841.736529-1-gengcixi@gmail.com>
References: <20201222054841.736529-1-gengcixi@gmail.com>
Message-ID: <20201222054841.736529-5-gengcixi@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Cixi Geng <cixi.geng1@unisoc.com>

add compile module generate files into .gitignore

file:
	testcases/commands/lsmod/.built-in.a.cmd
	testcases/commands/lsmod/.ltp_lsmod01.ko.cmd
	testcases/commands/lsmod/.ltp_lsmod01.mod.cmd
	testcases/commands/lsmod/.ltp_lsmod01.mod.o.cmd
	testcases/commands/lsmod/.ltp_lsmod01.o.cmd
	testcases/commands/lsmod/Module.symvers
	testcases/commands/lsmod/ltp_lsmod01.mod.c
	testcases/commands/lsmod/modules.order

Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 testcases/commands/lsmod/.gitignore | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 testcases/commands/lsmod/.gitignore

diff --git a/testcases/commands/lsmod/.gitignore b/testcases/commands/lsmod/.gitignore
new file mode 100644
index 000000000..0e19fb3fd
--- /dev/null
+++ b/testcases/commands/lsmod/.gitignore
@@ -0,0 +1,9 @@
+*.ko
+*.mod.c
+*.ko.cmd
+*.mod.cmd
+*.mod.o.cmd
+*.o.cmd
+.built-in.a.cmd
+Module.symvers
+modules.order
-- 
2.25.1

