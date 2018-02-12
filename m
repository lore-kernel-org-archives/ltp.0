From: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
Date: Mon, 12 Feb 2018 18:21:35 +0800
Subject: [LTP] [PATCH 1/4] syscalls/readlink.h: Move common macros to
	readlink.h
Message-ID: <1518430898-13225-1-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/readlink/readlink.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 testcases/kernel/syscalls/readlink/readlink.h

diff --git a/testcases/kernel/syscalls/readlink/readlink.h b/testcases/kernel/syscalls/readlink/readlink.h
new file mode 100644
index 0000000..0361157
--- /dev/null
+++ b/testcases/kernel/syscalls/readlink/readlink.h
@@ -0,0 +1,26 @@
+/*
+* Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
+* Author: Jinhui huang <huangjh.jy@cn.fujitsu.com>
+*
+* This program is free software; you can redistribute it and/or modify it
+* under the terms of version 2 of the GNU General Public License as
+* published by the Free Software Foundation.
+*
+* This program is distributed in the hope that it would be useful, but
+* WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+*
+* You should have received a copy of the GNU General Public License
+* alone with this program.
+*/
+
+#ifndef	READLINK_H
+#define	READLINK_H
+
+#define TESTFILE	"test_file"
+#define SYMFILE	"slink_file"
+#define FILE_MODE	(S_IRUSR | S_IRGRP | S_IROTH)
+#define MODE_RWX	(S_IRWXU | S_IRWXG | S_IRWXO)
+#define MAX_SIZE	256
+
+#endif /* READLINK_H */
-- 
1.8.3.1



