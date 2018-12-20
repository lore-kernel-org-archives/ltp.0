From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 20 Dec 2018 14:00:25 +0800
Subject: [LTP] [PATCH] openposix/threads: Add missing Makefile
Message-ID: <1545285625-11556-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The Makefile in functional/threads directory was removed by mistake.

Fixes: 310c9eb ("Remove explicit #define's for `_POSIX_C_SOURCE` and `_XOPEN_SOURCE`")

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/open_posix_testsuite/functional/threads/Makefile | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 testcases/open_posix_testsuite/functional/threads/Makefile

diff --git a/testcases/open_posix_testsuite/functional/threads/Makefile b/testcases/open_posix_testsuite/functional/threads/Makefile
new file mode 100644
index 0000000..6cf8b06
--- /dev/null
+++ b/testcases/open_posix_testsuite/functional/threads/Makefile
@@ -0,0 +1,10 @@
+#
+# Read COPYING for licensing details.
+#
+# Ngie Cooper, June 2010
+#
+
+all clean install test:
+	@for dir in `ls -d */Makefile 2>/dev/null | sed -e 's,/Makefile$$,,g'`; do \
+		$(MAKE) -C $$dir $@;						   \
+	done
-- 
1.8.3.1



