From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 2 Mar 2016 18:03:46 +0800
Subject: [LTP] [PATCH] syscalls/recvmsg02: Add header file lapi/socket.h
Message-ID: <1456913026-10877-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Compilation failed on RHEL5.11GA because SOCK_CLOEXEC is
not included in sys/socket.h on RHEL5.11GA, so fix it.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 include/lapi/socket.h                         | 26 ++++++++++++++++++++++++++
 testcases/kernel/syscalls/recvmsg/recvmsg02.c |  6 ++++++
 2 files changed, 32 insertions(+)
 create mode 100644 include/lapi/socket.h

diff --git a/include/lapi/socket.h b/include/lapi/socket.h
new file mode 100644
index 0000000..ecad9bd
--- /dev/null
+++ b/include/lapi/socket.h
@@ -0,0 +1,26 @@
+/*
+* Copyright (c) 20156 Fujitsu Ltd.
+* Author: Xiao Yang <fenggw-fnst@cn.fujitsu.com>
+*
+* This program is free software; you can redistribute it and/or
+* modify it under the terms of the GNU General Public License as
+* published by the Free Software Foundation; either version 2 of
+* the License, or (at your option) any later version.
+*
+* This program is distributed in the hope that it would be useful,
+* but WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+* GNU General Public License for more details.
+*
+* You should have received a copy of the GNU General Public License
+* along with this program.
+*/
+
+#ifndef __LAPI_SOCKET_H__
+#define __LAPI_SOCKET_H__
+
+#ifndef SOCK_CLOEXEC
+# define SOCK_CLOEXEC 02000000
+#endif
+
+#endif /* __LAPI_SOCKET_H__ */
diff --git a/testcases/kernel/syscalls/recvmsg/recvmsg02.c b/testcases/kernel/syscalls/recvmsg/recvmsg02.c
index 5c15524..e921f79 100644
--- a/testcases/kernel/syscalls/recvmsg/recvmsg02.c
+++ b/testcases/kernel/syscalls/recvmsg/recvmsg02.c
@@ -34,6 +34,7 @@
 
 #include "test.h"
 #include "safe_macros.h"
+#include "lapi/socket.h"
 
 const char *TCID = "recvmsg02";
 int TST_TOTAL = 1;
@@ -102,6 +103,11 @@ int main(int argc, char *argv[])
 {
 	int lc;
 
+	if ((tst_kvercmp(2, 6, 27)) < 0) {
+		tst_brkm(TCONF, NULL, "This test can only run on kernels"
+			 "that are 2.6.27 and higher");
+	}
+
 	tst_parse_opts(argc, argv, NULL, NULL);
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc)
-- 
1.8.3.1



