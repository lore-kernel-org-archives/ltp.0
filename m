From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 7 Dec 2016 13:16:37 +0800
Subject: [LTP] [PATCH v2 2/5] syscalls/ipc: add newipc library for new API
In-Reply-To: <1481087800-20639-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20161123135513.GI3346@rei.lan>
 <1481087800-20639-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1481087800-20639-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/ipc/Makefile             |  40 +++---
 testcases/kernel/syscalls/ipc/libnewipc/Makefile   |  24 ++++
 .../kernel/syscalls/ipc/libnewipc/libnewipc.c      | 145 +++++++++++++++++++++
 .../kernel/syscalls/ipc/libnewipc/libnewipc.h      |  52 ++++++++
 4 files changed, 240 insertions(+), 21 deletions(-)
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
index 0000000..e5190f9
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
+LIB			:= libnewipc.a
+
+include $(top_srcdir)/include/mk/lib.mk
diff --git a/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.c b/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.c
new file mode 100644
index 0000000..5e27662
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.c
@@ -0,0 +1,145 @@
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
+ *
+ * The library contains the following routines:
+ * getipckey()
+ * rm_queue()
+ * rm_sema()
+ * rm_shm()
+ * get_used_msgqueues()
+ * get_max_msgqueues()
+ */
+
+#define NEWLIBIPC
+
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdlib.h>
+#include <pwd.h>
+#include <sys/types.h>
+#include <sys/ipc.h>
+#include <sys/msg.h>
+#include <sys/shm.h>
+#include <sys/sem.h>
+
+#include "libnewipc.h"
+#include "tst_res_flags.h"
+#include "tst_res.h"
+#include "tst_safe_macros.h"
+#include "lapi/semun.h"
+
+#define BUFSIZE 512
+
+key_t getipckey(void)
+{
+	int ascii_a = (int) 'a';
+	char buf[BUFSIZE];
+	key_t key;
+	int id;
+	static int count;
+
+	SAFE_GETCWD(buf, BUFSIZE);
+
+	id = count % 26 + ascii_a;
+	count++;
+
+	key = ftok(buf, id);
+	if (key == -1)
+		tst_brk(TBROK | TERRNO, "ftok() failed");
+
+	return key;
+}
+
+void rm_queue(int queue_id)
+{
+	if (queue_id == -1)
+		return;
+
+	if (msgctl(queue_id, IPC_RMID, NULL) == -1) {
+		tst_res(TINFO, "WARNING: message queue deletion failed.");
+		tst_res(TINFO, "This could lead to IPC resource problems.");
+		tst_res(TINFO, "id = %d", queue_id);
+	}
+}
+
+void rm_sema(int sem_id)
+{
+	union semun arr;
+
+	if (sem_id == -1)
+		return;
+
+	if (semctl(sem_id, 0, IPC_RMID, arr) == -1) {
+		tst_res(TINFO, "WARNING: semaphore deletion failed.");
+		tst_res(TINFO, "This could lead to IPC resource problems.");
+		tst_res(TINFO, "id = %d", sem_id);
+	}
+}
+
+void rm_shm(int shm_id)
+{
+	if (shm_id == -1)
+		return;
+
+	if (shmctl(shm_id, IPC_RMID, NULL) == -1) {
+		tst_res(TINFO, "WARNING: shared memory deletion failed.");
+		tst_res(TINFO, "This could lead to IPC resource problems.");
+		tst_res(TINFO, "id = %d", shm_id);
+	}
+}
+
+int get_used_msgqueues(void)
+{
+	FILE *f;
+	int used_queues;
+	char buf[BUFSIZE];
+
+	f = popen("ipcs -q", "r");
+	if (!f)
+		tst_brk(TBROK | TERRNO, "pipe failed");
+
+	/* FIXME: Start at -4 because ipcs prints four lines of header */
+	for (used_queues = -4; fgets(buf, BUFSIZE, f); used_queues++);
+
+	pclose(f);
+
+	if (used_queues < 0) {
+		tst_brk(TBROK, "Could not read output of 'ipcs' to "
+			"calculate used message queues");
+	}
+
+	return used_queues;
+}
+
+int get_max_msgqueues(void)
+{
+	int fd;
+	char buf[BUFSIZE];
+
+	fd = SAFE_OPEN("/proc/sys/kernel/msgmni", O_RDONLY);
+
+	SAFE_READ(0, fd, buf, BUFSIZE);
+
+	SAFE_CLOSE(fd);
+
+	return atoi(buf);
+}
diff --git a/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.h b/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.h
new file mode 100644
index 0000000..6a3064d
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.h
@@ -0,0 +1,52 @@
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
+#ifndef __NEWIPC_H
+#define __NEWIPC_H	1
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
+key_t getipckey(void);
+void rm_queue(int queue_id);
+void rm_sem(int sem_id);
+void rm_shm(int shm_id);
+int get_used_msgqueues(void);
+int get_max_msgqueues(void);
+
+#endif /* newlibipc.h */
-- 
1.8.3.1



