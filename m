From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 8 Jun 2020 12:07:36 +0800
Subject: [LTP] [PATCH] syscall/ipc: use LTPLIBS instead of LDFLAGS
Message-ID: <1591589256-21750-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The old discussion is here[1].
Also including the above changes from cyril, it has other changes as
below:
1)Add libmsgctl.c to newipc, so new api case also can call it.
2)For msgsnd05,06, remove uclinux judgment.

[1]http://lists.linux.it/pipermail/ltp/2020-May/017344.html

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
Hi Cyril
I have sent a email about this, but you don't reply. I guess you are
busy with other things. So I send this patch with your sign-off-by.


 libs/libltpipc/Makefile                       |   2 +-
 libs/libltpnewipc/libmsgctl.c                 | 147 ++++++++++++++++++
 testcases/kernel/syscalls/ipc/msgctl/Makefile |   3 +-
 testcases/kernel/syscalls/ipc/msgget/Makefile |   3 +-
 testcases/kernel/syscalls/ipc/msgrcv/Makefile |   3 +-
 testcases/kernel/syscalls/ipc/msgsnd/Makefile |   5 +-
 .../kernel/syscalls/ipc/msgstress/Makefile    |   4 +-
 testcases/kernel/syscalls/ipc/semctl/Makefile |   3 +-
 testcases/kernel/syscalls/ipc/semget/Makefile |   3 +-
 testcases/kernel/syscalls/ipc/semop/Makefile  |   3 +-
 testcases/kernel/syscalls/ipc/shmat/Makefile  |   3 +-
 testcases/kernel/syscalls/ipc/shmctl/Makefile |   3 +-
 testcases/kernel/syscalls/ipc/shmdt/Makefile  |   3 +-
 testcases/kernel/syscalls/ipc/shmget/Makefile |   3 +-
 testcases/kernel/syscalls/kill/Makefile       |   3 +-
 testcases/kernel/syscalls/mremap/Makefile     |   3 +-
 16 files changed, 175 insertions(+), 19 deletions(-)
 create mode 100644 libs/libltpnewipc/libmsgctl.c

diff --git a/libs/libltpipc/Makefile b/libs/libltpipc/Makefile
index 11f38ea0a..9fdc57894 100644
--- a/libs/libltpipc/Makefile
+++ b/libs/libltpipc/Makefile
@@ -5,7 +5,7 @@ top_srcdir		?= ../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-LIB			:= libltpipc.a libltpmsgctl.a
+LIB			:= libltpipc.a
 
 include $(top_srcdir)/include/mk/lib.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/libs/libltpnewipc/libmsgctl.c b/libs/libltpnewipc/libmsgctl.c
new file mode 100644
index 000000000..ae459d480
--- /dev/null
+++ b/libs/libltpnewipc/libmsgctl.c
@@ -0,0 +1,147 @@
+/*
+ * Copyright (c) International Business Machines  Corp., 2002
+ * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/ipc.h>
+#include <sys/msg.h>
+#include "libmsgctl.h"
+
+int doreader(long key, int tid, long type, int child, int nreps)
+{
+	int i, size;
+	int id;
+	struct mbuffer buffer;
+
+	id = msgget(key, 0);
+	if (id < 0) {
+		printf("msgget() error in the reader of child group %d: %s\n",
+			child, strerror(errno));
+
+		return FAIL;
+	}
+	if (id != tid) {
+		printf("Message queue mismatch in the reader of child group %d for message queue id %d\n",
+			child, id);
+
+		return FAIL;
+	}
+	for (i = 0; i < nreps; i++) {
+		memset(&buffer, 0, sizeof(buffer));
+
+		size = msgrcv(id, &buffer, 100, type, 0);
+		if (size < 0) {
+			printf("msgrcv() error in child %d, read # = %d: %s\n",
+				child, (i + 1), strerror(errno));
+
+			return FAIL;
+		}
+		if (buffer.type != type) {
+			printf("Type mismatch in child %d, read #d = %d: ",
+				child, (i + 1));
+			printf("for message got %ld, expected - %ld\n",
+				buffer.type, type);
+
+			return FAIL;
+		}
+		if (buffer.data.len + 1 != size) {
+			printf("Size mismatch in child %d, read # = %d: ",
+				child, (i + 1));
+			printf("for message got %d, expected - %d\n",
+				buffer.data.len + 1, size);
+
+			return FAIL;
+		}
+		if (verify(buffer.data.pbytes, (key % 255), size - 1, child)) {
+			printf("Verify failed in child %d read # = %d, key = %lx\n",
+				child, (i + 1), key);
+
+			return FAIL;
+		}
+		key++;
+	}
+	return PASS;
+}
+
+int dowriter(long key, int tid, long type, int child, int nreps)
+{
+	int i, size;
+	int id;
+	struct mbuffer buffer;
+
+	id = msgget(key, 0);
+	if (id < 0) {
+		printf("msgget() error in the writer of child group %d: %s\n",
+			child, strerror(errno));
+
+		return FAIL;
+	}
+	if (id != tid) {
+		printf("Message queue mismatch in the reader of child group %d for message queue id %d\n",
+			child, id);
+
+		return FAIL;
+	}
+
+	for (i = 0; i < nreps; i++) {
+		memset(&buffer, 0, sizeof(buffer));
+
+		do {
+			size = (lrand48() % 99);
+		} while (size == 0);
+		fill_buffer(buffer.data.pbytes, (key % 255), size);
+		buffer.data.len = size;
+		buffer.type = type;
+		if (msgsnd(id, &buffer, size + 1, 0) < 0) {
+			printf("msgsnd() error in child %d, write # = %d, key = %lx: %s\n",
+				child, nreps, key, strerror(errno));
+
+			return FAIL;
+		}
+		key++;
+	}
+	return PASS;
+}
+
+int fill_buffer(char *buf, char val, int size)
+{
+	int i;
+
+	for (i = 0; i < size; i++)
+		buf[i] = val;
+	return 0;
+}
+
+/* Check a buffer for correct values */
+int verify(char *buf, char val, int size, int child)
+{
+	while (size-- > 0) {
+		if (*buf++ != val) {
+			printf("Verify error in child %d, *buf = %x, val = %x, size = %d\n",
+				child, *buf, val, size);
+
+			return FAIL;
+		}
+	}
+	return PASS;
+}
diff --git a/testcases/kernel/syscalls/ipc/msgctl/Makefile b/testcases/kernel/syscalls/ipc/msgctl/Makefile
index e2b305573..a11cbcf2e 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/Makefile
+++ b/testcases/kernel/syscalls/ipc/msgctl/Makefile
@@ -3,9 +3,10 @@
 
 top_srcdir              ?= ../../../../..
 
+LTPLIBS = ltpnewipc
+
 include $(top_srcdir)/include/mk/testcases.mk
 
 LDLIBS  += -lltpnewipc
-LDFLAGS += -L$(top_builddir)/libs/libltpnewipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/msgget/Makefile b/testcases/kernel/syscalls/ipc/msgget/Makefile
index e2b305573..a11cbcf2e 100644
--- a/testcases/kernel/syscalls/ipc/msgget/Makefile
+++ b/testcases/kernel/syscalls/ipc/msgget/Makefile
@@ -3,9 +3,10 @@
 
 top_srcdir              ?= ../../../../..
 
+LTPLIBS = ltpnewipc
+
 include $(top_srcdir)/include/mk/testcases.mk
 
 LDLIBS  += -lltpnewipc
-LDFLAGS += -L$(top_builddir)/libs/libltpnewipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/Makefile b/testcases/kernel/syscalls/ipc/msgrcv/Makefile
index aa211d37f..f62cd1f48 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/Makefile
+++ b/testcases/kernel/syscalls/ipc/msgrcv/Makefile
@@ -3,9 +3,10 @@
 
 top_srcdir              ?= ../../../../..
 
+LTPLIBS = ltpipc
+
 include $(top_srcdir)/include/mk/testcases.mk
 
 LDLIBS  += -lltpipc
-LDFLAGS += -L$(top_builddir)/libs/libltpipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/Makefile b/testcases/kernel/syscalls/ipc/msgsnd/Makefile
index b4930310f..a11cbcf2e 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/Makefile
+++ b/testcases/kernel/syscalls/ipc/msgsnd/Makefile
@@ -3,13 +3,10 @@
 
 top_srcdir              ?= ../../../../..
 
-ifeq ($(UCLINUX),1)
-FILTER_OUT_MAKE_TARGETS += msgsnd05 msgsnd06
-endif
+LTPLIBS = ltpnewipc
 
 include $(top_srcdir)/include/mk/testcases.mk
 
 LDLIBS  += -lltpnewipc
-LDFLAGS += -L$(top_builddir)/libs/libltpnewipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/msgstress/Makefile b/testcases/kernel/syscalls/ipc/msgstress/Makefile
index 551463829..f62cd1f48 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/Makefile
+++ b/testcases/kernel/syscalls/ipc/msgstress/Makefile
@@ -3,10 +3,10 @@
 
 top_srcdir              ?= ../../../../..
 
+LTPLIBS = ltpipc
+
 include $(top_srcdir)/include/mk/testcases.mk
 
 LDLIBS  += -lltpipc
-LDLIBS  += -lltpmsgctl
-LDFLAGS += -L$(top_builddir)/libs/libltpipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/semctl/Makefile b/testcases/kernel/syscalls/ipc/semctl/Makefile
index aa211d37f..f62cd1f48 100644
--- a/testcases/kernel/syscalls/ipc/semctl/Makefile
+++ b/testcases/kernel/syscalls/ipc/semctl/Makefile
@@ -3,9 +3,10 @@
 
 top_srcdir              ?= ../../../../..
 
+LTPLIBS = ltpipc
+
 include $(top_srcdir)/include/mk/testcases.mk
 
 LDLIBS  += -lltpipc
-LDFLAGS += -L$(top_builddir)/libs/libltpipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/semget/Makefile b/testcases/kernel/syscalls/ipc/semget/Makefile
index aa211d37f..f62cd1f48 100644
--- a/testcases/kernel/syscalls/ipc/semget/Makefile
+++ b/testcases/kernel/syscalls/ipc/semget/Makefile
@@ -3,9 +3,10 @@
 
 top_srcdir              ?= ../../../../..
 
+LTPLIBS = ltpipc
+
 include $(top_srcdir)/include/mk/testcases.mk
 
 LDLIBS  += -lltpipc
-LDFLAGS += -L$(top_builddir)/libs/libltpipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/semop/Makefile b/testcases/kernel/syscalls/ipc/semop/Makefile
index aa211d37f..f62cd1f48 100644
--- a/testcases/kernel/syscalls/ipc/semop/Makefile
+++ b/testcases/kernel/syscalls/ipc/semop/Makefile
@@ -3,9 +3,10 @@
 
 top_srcdir              ?= ../../../../..
 
+LTPLIBS = ltpipc
+
 include $(top_srcdir)/include/mk/testcases.mk
 
 LDLIBS  += -lltpipc
-LDFLAGS += -L$(top_builddir)/libs/libltpipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/shmat/Makefile b/testcases/kernel/syscalls/ipc/shmat/Makefile
index e2b305573..a11cbcf2e 100644
--- a/testcases/kernel/syscalls/ipc/shmat/Makefile
+++ b/testcases/kernel/syscalls/ipc/shmat/Makefile
@@ -3,9 +3,10 @@
 
 top_srcdir              ?= ../../../../..
 
+LTPLIBS = ltpnewipc
+
 include $(top_srcdir)/include/mk/testcases.mk
 
 LDLIBS  += -lltpnewipc
-LDFLAGS += -L$(top_builddir)/libs/libltpnewipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/shmctl/Makefile b/testcases/kernel/syscalls/ipc/shmctl/Makefile
index dda6d636f..cfa5d6e76 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/Makefile
+++ b/testcases/kernel/syscalls/ipc/shmctl/Makefile
@@ -3,12 +3,13 @@
 
 top_srcdir              ?= ../../../../..
 
+LTPLIBS = ltpipc
+
 shmctl05: CFLAGS += -pthread
 shmctl05: LDLIBS += -lrt
 
 include $(top_srcdir)/include/mk/testcases.mk
 
 LDLIBS  += -lltpipc
-LDFLAGS += -L$(top_builddir)/libs/libltpipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/shmdt/Makefile b/testcases/kernel/syscalls/ipc/shmdt/Makefile
index aa211d37f..f62cd1f48 100644
--- a/testcases/kernel/syscalls/ipc/shmdt/Makefile
+++ b/testcases/kernel/syscalls/ipc/shmdt/Makefile
@@ -3,9 +3,10 @@
 
 top_srcdir              ?= ../../../../..
 
+LTPLIBS = ltpipc
+
 include $(top_srcdir)/include/mk/testcases.mk
 
 LDLIBS  += -lltpipc
-LDFLAGS += -L$(top_builddir)/libs/libltpipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/shmget/Makefile b/testcases/kernel/syscalls/ipc/shmget/Makefile
index aa211d37f..f62cd1f48 100644
--- a/testcases/kernel/syscalls/ipc/shmget/Makefile
+++ b/testcases/kernel/syscalls/ipc/shmget/Makefile
@@ -3,9 +3,10 @@
 
 top_srcdir              ?= ../../../../..
 
+LTPLIBS = ltpipc
+
 include $(top_srcdir)/include/mk/testcases.mk
 
 LDLIBS  += -lltpipc
-LDFLAGS += -L$(top_builddir)/libs/libltpipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/kill/Makefile b/testcases/kernel/syscalls/kill/Makefile
index 3e32978fc..27b24993e 100644
--- a/testcases/kernel/syscalls/kill/Makefile
+++ b/testcases/kernel/syscalls/kill/Makefile
@@ -3,9 +3,10 @@
 
 top_srcdir		?= ../../../..
 
+LTPLIBS = ltpipc
+
 include $(top_srcdir)/include/mk/testcases.mk
 
 LDLIBS  += -lltpipc
-LDFLAGS += -L$(top_builddir)/libs/libltpipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/mremap/Makefile b/testcases/kernel/syscalls/mremap/Makefile
index 3e32978fc..27b24993e 100644
--- a/testcases/kernel/syscalls/mremap/Makefile
+++ b/testcases/kernel/syscalls/mremap/Makefile
@@ -3,9 +3,10 @@
 
 top_srcdir		?= ../../../..
 
+LTPLIBS = ltpipc
+
 include $(top_srcdir)/include/mk/testcases.mk
 
 LDLIBS  += -lltpipc
-LDFLAGS += -L$(top_builddir)/libs/libltpipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.23.0



