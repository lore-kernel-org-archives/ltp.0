From: gengcixi@gmail.com <gengcixi@gmail.com>
Date: Tue, 22 Dec 2020 13:48:40 +0800
Subject: [LTP] [PATCH 3/4] insmod:add gitignore files
In-Reply-To: <20201222054841.736529-1-gengcixi@gmail.com>
References: <20201222054841.736529-1-gengcixi@gmail.com>
Message-ID: <20201222054841.736529-4-gengcixi@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Cixi Geng <cixi.geng1@unisoc.com>

add compile module generate files into .gitignore

file:
	testcases/commands/insmod/.built-in.a.cmd
	testcases/commands/insmod/.ltp_insmod01.ko.cmd
	testcases/commands/insmod/.ltp_insmod01.mod.cmd
	testcases/commands/insmod/.ltp_insmod01.mod.o.cmd
	testcases/commands/insmod/.ltp_insmod01.o.cmd
	testcases/commands/insmod/Module.symvers
	testcases/commands/insmod/ltp_insmod01.mod.c
	testcases/commands/insmod/modules.order

Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 testcases/commands/insmod/.gitignore | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 testcases/commands/insmod/.gitignore

diff --git a/testcases/commands/insmod/.gitignore b/testcases/commands/insmod/.gitignore
new file mode 100644
index 000000000..0e19fb3fd
--- /dev/null
+++ b/testcases/commands/insmod/.gitignore
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

