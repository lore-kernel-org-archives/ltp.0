From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 13 Dec 2016 15:39:02 +0800
Subject: [LTP] [PATCH v3 1/4] syscalls/ipc: add newipc library for new API
In-Reply-To: <20161212142847.GD21828@rei.lan>
References: <20161212142847.GD21828@rei.lan>
Message-ID: <1481614745-27778-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/ipc/Makefile             | 40 +++++------
 testcases/kernel/syscalls/ipc/libnewipc/Makefile   | 24 +++++++
 .../kernel/syscalls/ipc/libnewipc/libnewipc.c      | 81 ++++++++++++++++++++++
 .../kernel/syscalls/ipc/libnewipc/libnewipc.h      | 53 ++++++++++++++
 4 files changed, 177 insertions(+), 21 deletions(-)
 create mode 100644 testcases/kernel/syscalls/ipc/libnewipc/Makefile
 create mode 100644 testcases/kernel/syscalls/ipc/libnewipc/libnewipc.c
 create mode 100644 testcases/kernel/syscalls/ipc/libnewipc/libnewipc.h

diff --git a/testcases/kernel/syscalls/ipc/Makefile b/testcases/kernel/syscalls/ipc/Makefile
index 42492db..ca49e49 100644
--- a/testcases/kernel/syscalls/ipc/Makefile
+++ b/testcases/kernel/syscalls/ipc/Makefile
@@ -1,19 +1,18 @@
 #
-#  Copyright (c) International Business Machines  Corp., 2001
+# Copyright (c) International Business Machines  Corp., 2001
 #
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
+# This program is free software;  you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
 #
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY;  without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+# the GNU General Public License for more details.
 #
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+# You should have received a copy of the GNU General Public License
+# along with this program.
 #
 
 top_srcdir		?= ../../../..
@@ -21,20 +20,19 @@ top_srcdir		?= ../../../..
 include $(top_srcdir)/include/mk/env_pre.mk
 
 LIBDIR			:= lib
-FILTER_OUT_DIRS		:= $(LIBDIR)
-LIB			:= $(LIBDIR)/libipc.a $(LIBDIR)/libmsgctl.a
+NEWLIBDIR		:= libnewipc
+LIB			:= $(LIBDIR)/libipc.a $(LIBDIR)/libmsgctl.a $(NEWLIBDIR)/libnewipc.a
 
-$(LIBDIR):
-	mkdir -p "$@"
-
-$(LIB): $(LIBDIR)
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
+$(LIB): $(LIBDIR) $(NEWLIBDIR)
+	$(MAKE) -C $(LIBDIR) -f "$(abs_srcdir)/$(LIBDIR)/Makefile" all
+	$(MAKE) -C $(NEWLIBDIR) -f "$(abs_srcdir)/$(NEWLIBDIR)/Makefile" all
 
 MAKE_DEPS		:= $(LIB)
 
 trunk-clean:: | lib-clean
 
-lib-clean:: $(LIBDIR)
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
+lib-clean:: $(LIBDIR) $(NEWLIBDIR)
+	$(MAKE) -C $(LIBDIR) -f "$(abs_srcdir)/$(LIBDIR)/Makefile" clean
+	$(MAKE) -C $(NEWLIBDIR) -f "$(abs_srcdir)/$(NEWLIBDIR)/Makefile" clean
 
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/syscalls/ipc/libnewipc/Makefile b/testcases/kernel/syscalls/ipc/libnewipc/Makefile
new file mode 100644
index 0000000..efd8da7
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/libnewipc/Makefile
@@ -0,0 +1,24 @@
+#
+# Copyright (c) 2016 Xiao Yang <yangx.jy@cn.fujitsu.com>
+#
+# This program is free software;  you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY;  without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+# the GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.
+#
+
+top_srcdir		?= ../../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+INTERNAL_LIB		:= libnewipc.a
+
+include $(top_srcdir)/include/mk/lib.mk
diff --git a/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.c b/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.c
new file mode 100644
index 0000000..8ea421f
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.c
@@ -0,0 +1,81 @@
+/*
+ * Copyright (c) 2016 Xiao Yang <yangx.jy@cn.fujitsu.com>
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.
+ */
+
+/*
+ * DESCRIPTION
+ * common routines for the IPC system call tests.
+ */
+
+#include <errno.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/ipc.h>
+
+#define	TST_NO_DEFAULT_MAIN
+
+#include "tst_test.h"
+#include "libnewipc.h"
+
+#define BUFSIZE 1024
+
+key_t getipckey(const char *file, const int lineno)
+{
+	char buf[BUFSIZE];
+	key_t key;
+	int id;
+	static int count;
+
+	SAFE_GETCWD(buf, BUFSIZE);
+
+	id = count % 26 + (int) 'a';
+	count++;
+
+	key = ftok(buf, id);
+	if (key == -1) {
+		tst_brk(TBROK | TERRNO,
+			"ftok() failed at %s:%d", file, lineno);
+	}
+
+	return key;
+}
+
+int get_used_queues(const char *file, const int lineno)
+{
+	FILE *fp;
+	int used_queues = -1;
+	char buf[BUFSIZE];
+
+	fp = fopen("/proc/sysvipc/msg", "r");
+	if (fp == NULL) {
+		tst_brk(TBROK | TERRNO,
+			"fopen() failed at %s:%d", file, lineno);
+	}
+
+	while (fgets(buf, BUFSIZE, fp) != NULL)
+		used_queues++;
+
+	fclose(fp);
+
+	if (used_queues < 0) {
+		tst_brk(TBROK, "can't read /proc/sysvipc/msg to get "
+			"used message queues@%s:%d", file, lineno);
+	}
+
+	return used_queues;
+}
diff --git a/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.h b/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.h
new file mode 100644
index 0000000..39148be
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.h
@@ -0,0 +1,53 @@
+/*
+ * Copyright (c) 2016 Xiao Yang <yangx.jy@cn.fujitsu.com>
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.
+ */
+
+/*
+ * common definitions for the IPC system calls.
+ */
+
+#ifndef __LIBNEWIPC_H
+#define __LIBNEWIPC_H	1
+
+#define MSG_RD	0400
+#define MSG_WR	0200
+#define MSG_RW	(MSG_RD | MSG_WR)
+#define MSGSIZE	1024
+#define MSGTYPE	1
+#define NR_MSGQUEUES	16
+#define min(a, b)	(((a) < (b)) ? @ : (b))
+
+#define SEM_RD	0400
+#define SEM_ALT	0200
+#define SEM_RA	(SEM_RD | SEM_ALT)
+#define PSEMS	10
+
+#define SHM_RD	0400
+#define SHM_WR	0200
+#define SHM_RW	(SHM_RD | SHM_WR)
+#define SHM_SIZE	2048
+#define INT_SIZE	4
+#define MODE_MASK	0x01FF
+
+key_t getipckey(const char *file, const int lineno);
+#define GETIPCKEY() \
+	getipckey(__FILE__, __LINE__)
+
+int get_used_queues(const char *file, const int lineno);
+#define GET_USED_QUEUES() \
+	get_used_queues(__FILE__, __LINE__)
+
+#endif /* newlibipc.h */
-- 
1.8.3.1



