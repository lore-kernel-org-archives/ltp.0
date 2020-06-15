From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 15 Jun 2020 11:08:33 +0200
Subject: [LTP] [COMMITTED] [PATCH] Fix syscalls/ipc: Move libraries to libs/
 directory
Message-ID: <20200615090833.23001-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Apparently I have forgotten to amend the changes when I applied the
patch, sorry for that.

Fixes: afdd429714ad (syscalls/ipc: Move libraries to libs/ director)
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 libs/libltpipc/Makefile                          | 2 +-
 testcases/kernel/syscalls/ipc/msgctl/Makefile    | 3 ++-
 testcases/kernel/syscalls/ipc/msgget/Makefile    | 3 ++-
 testcases/kernel/syscalls/ipc/msgrcv/Makefile    | 3 ++-
 testcases/kernel/syscalls/ipc/msgsnd/Makefile    | 3 ++-
 testcases/kernel/syscalls/ipc/msgstress/Makefile | 4 ++--
 testcases/kernel/syscalls/ipc/semctl/Makefile    | 3 ++-
 testcases/kernel/syscalls/ipc/semget/Makefile    | 3 ++-
 testcases/kernel/syscalls/ipc/semop/Makefile     | 3 ++-
 testcases/kernel/syscalls/ipc/shmat/Makefile     | 3 ++-
 testcases/kernel/syscalls/ipc/shmctl/Makefile    | 3 ++-
 testcases/kernel/syscalls/ipc/shmdt/Makefile     | 3 ++-
 testcases/kernel/syscalls/ipc/shmget/Makefile    | 3 ++-
 testcases/kernel/syscalls/kill/Makefile          | 6 ++++--
 testcases/kernel/syscalls/mremap/Makefile        | 5 +++--
 15 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/libs/libltpipc/Makefile b/libs/libltpipc/Makefile
index fadd04833..ad8f5a23b 100644
--- a/libs/libltpipc/Makefile
+++ b/libs/libltpipc/Makefile
@@ -5,7 +5,7 @@ top_srcdir		?= ../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-INTERNAL_LIB		:= libltpipc.a libltpmsgctl.a
+INTERNAL_LIB			:= libltpipc.a
 
 include $(top_srcdir)/include/mk/lib.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
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
index b4930310f..17960cae3 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/Makefile
+++ b/testcases/kernel/syscalls/ipc/msgsnd/Makefile
@@ -3,6 +3,8 @@
 
 top_srcdir              ?= ../../../../..
 
+LTPLIBS = ltpnewipc
+
 ifeq ($(UCLINUX),1)
 FILTER_OUT_MAKE_TARGETS += msgsnd05 msgsnd06
 endif
@@ -10,6 +12,5 @@ endif
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
index 3e32978fc..00cadabef 100644
--- a/testcases/kernel/syscalls/kill/Makefile
+++ b/testcases/kernel/syscalls/kill/Makefile
@@ -3,9 +3,11 @@
 
 top_srcdir		?= ../../../..
 
+LTPLIBS = ltpipc
+
 include $(top_srcdir)/include/mk/testcases.mk
 
-LDLIBS  += -lltpipc
-LDFLAGS += -L$(top_builddir)/libs/libltpipc
+kill07: LDLIBS  += -lltpipc
+kill05: LDLIBS  += -lltpipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/mremap/Makefile b/testcases/kernel/syscalls/mremap/Makefile
index 3e32978fc..7bdf425d2 100644
--- a/testcases/kernel/syscalls/mremap/Makefile
+++ b/testcases/kernel/syscalls/mremap/Makefile
@@ -3,9 +3,10 @@
 
 top_srcdir		?= ../../../..
 
+LTPLIBS = ltpipc
+
 include $(top_srcdir)/include/mk/testcases.mk
 
-LDLIBS  += -lltpipc
-LDFLAGS += -L$(top_builddir)/libs/libltpipc
+mremap04: LDLIBS  += -lltpipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.26.2

