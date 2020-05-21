From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 21 May 2020 16:17:32 +0530
Subject: [LTP] [PATCH 1/5] syscalls:ipc: Move libraries to libs/ director
In-Reply-To: <cover.1590057824.git.viresh.kumar@linaro.org>
References: <cover.1590057824.git.viresh.kumar@linaro.org>
Message-ID: <3b3344651f2ba4bf2446b6730a76ebcd9f894dd0.1590057824.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Move the ipc libraries to libs/ directory. One of the reasons to do this
was to add the capability of adding tests with both old and new test
frameworks in the same ipc test directory.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../syscalls/ipc/lib => include}/ipcmsg.h     |  0
 .../syscalls/ipc/lib => include}/ipcsem.h     |  0
 .../syscalls/ipc/lib => include}/ipcshm.h     |  0
 .../syscalls/ipc/lib => include}/libmsgctl.h  |  0
 .../ipc/libnewipc => include}/libnewipc.h     |  2 ++
 .../ipc/lib => libs/libltpipc}/Makefile       |  5 ++--
 .../ipc/lib => libs/libltpipc}/libipc.c       |  0
 .../ipc/lib => libs/libltpipc}/libmsgctl.c    |  0
 .../libnewipc => libs/libltpnewipc}/Makefile  |  5 ++--
 .../libltpnewipc}/libnewipc.c                 |  0
 testcases/kernel/syscalls/ipc/Makefile        | 22 ---------------
 testcases/kernel/syscalls/ipc/Makefile.inc    | 28 -------------------
 testcases/kernel/syscalls/ipc/Makefile2.inc   | 22 ---------------
 testcases/kernel/syscalls/ipc/msgctl/Makefile |  5 +++-
 testcases/kernel/syscalls/ipc/msgget/Makefile |  5 +++-
 testcases/kernel/syscalls/ipc/msgrcv/Makefile |  5 +++-
 .../kernel/syscalls/ipc/msgrcv/msgrcv01.c     |  2 +-
 .../kernel/syscalls/ipc/msgrcv/msgrcv02.c     |  2 +-
 .../kernel/syscalls/ipc/msgrcv/msgrcv03.c     |  2 +-
 .../kernel/syscalls/ipc/msgrcv/msgrcv04.c     |  2 +-
 .../kernel/syscalls/ipc/msgrcv/msgrcv05.c     |  2 +-
 .../kernel/syscalls/ipc/msgrcv/msgrcv06.c     |  2 +-
 testcases/kernel/syscalls/ipc/msgsnd/Makefile |  5 +++-
 .../kernel/syscalls/ipc/msgstress/Makefile    |  8 ++----
 .../syscalls/ipc/msgstress/msgstress01.c      |  2 +-
 .../syscalls/ipc/msgstress/msgstress02.c      |  2 +-
 .../syscalls/ipc/msgstress/msgstress03.c      |  2 +-
 .../syscalls/ipc/msgstress/msgstress04.c      |  2 +-
 testcases/kernel/syscalls/ipc/semctl/Makefile |  5 +++-
 .../kernel/syscalls/ipc/semctl/semctl02.c     |  2 +-
 .../kernel/syscalls/ipc/semctl/semctl03.c     |  2 +-
 .../kernel/syscalls/ipc/semctl/semctl04.c     |  2 +-
 .../kernel/syscalls/ipc/semctl/semctl05.c     |  2 +-
 testcases/kernel/syscalls/ipc/semget/Makefile |  5 +++-
 .../kernel/syscalls/ipc/semget/semget01.c     |  4 +--
 .../kernel/syscalls/ipc/semget/semget02.c     |  4 +--
 .../kernel/syscalls/ipc/semget/semget03.c     |  4 +--
 .../kernel/syscalls/ipc/semget/semget05.c     |  2 +-
 .../kernel/syscalls/ipc/semget/semget06.c     |  4 +--
 testcases/kernel/syscalls/ipc/semop/Makefile  |  5 +++-
 testcases/kernel/syscalls/ipc/semop/semop03.c |  2 +-
 testcases/kernel/syscalls/ipc/semop/semop04.c |  2 +-
 testcases/kernel/syscalls/ipc/semop/semop05.c |  2 +-
 testcases/kernel/syscalls/ipc/shmat/Makefile  |  5 +++-
 testcases/kernel/syscalls/ipc/shmctl/Makefile |  5 +++-
 .../kernel/syscalls/ipc/shmctl/shmctl02.c     |  2 +-
 .../kernel/syscalls/ipc/shmctl/shmctl03.c     |  2 +-
 .../kernel/syscalls/ipc/shmctl/shmctl04.c     |  2 +-
 testcases/kernel/syscalls/ipc/shmdt/Makefile  |  5 +++-
 testcases/kernel/syscalls/ipc/shmdt/shmdt01.c |  2 +-
 testcases/kernel/syscalls/ipc/shmget/Makefile |  5 +++-
 .../kernel/syscalls/ipc/shmget/shmget01.c     |  2 +-
 .../kernel/syscalls/ipc/shmget/shmget02.c     |  2 +-
 .../kernel/syscalls/ipc/shmget/shmget03.c     |  2 +-
 .../kernel/syscalls/ipc/shmget/shmget04.c     |  2 +-
 .../kernel/syscalls/ipc/shmget/shmget05.c     |  2 +-
 testcases/kernel/syscalls/kill/Makefile       | 19 ++-----------
 testcases/kernel/syscalls/kill/kill07.c       |  2 +-
 testcases/kernel/syscalls/mremap/Makefile     | 19 ++-----------
 59 files changed, 95 insertions(+), 162 deletions(-)
 rename {testcases/kernel/syscalls/ipc/lib => include}/ipcmsg.h (100%)
 rename {testcases/kernel/syscalls/ipc/lib => include}/ipcsem.h (100%)
 rename {testcases/kernel/syscalls/ipc/lib => include}/ipcshm.h (100%)
 rename {testcases/kernel/syscalls/ipc/lib => include}/libmsgctl.h (100%)
 rename {testcases/kernel/syscalls/ipc/libnewipc => include}/libnewipc.h (98%)
 rename {testcases/kernel/syscalls/ipc/lib => libs/libltpipc}/Makefile (63%)
 rename {testcases/kernel/syscalls/ipc/lib => libs/libltpipc}/libipc.c (100%)
 rename {testcases/kernel/syscalls/ipc/lib => libs/libltpipc}/libmsgctl.c (100%)
 rename {testcases/kernel/syscalls/ipc/libnewipc => libs/libltpnewipc}/Makefile (63%)
 rename {testcases/kernel/syscalls/ipc/libnewipc => libs/libltpnewipc}/libnewipc.c (100%)
 delete mode 100644 testcases/kernel/syscalls/ipc/Makefile.inc
 delete mode 100644 testcases/kernel/syscalls/ipc/Makefile2.inc

diff --git a/testcases/kernel/syscalls/ipc/lib/ipcmsg.h b/include/ipcmsg.h
similarity index 100%
rename from testcases/kernel/syscalls/ipc/lib/ipcmsg.h
rename to include/ipcmsg.h
diff --git a/testcases/kernel/syscalls/ipc/lib/ipcsem.h b/include/ipcsem.h
similarity index 100%
rename from testcases/kernel/syscalls/ipc/lib/ipcsem.h
rename to include/ipcsem.h
diff --git a/testcases/kernel/syscalls/ipc/lib/ipcshm.h b/include/ipcshm.h
similarity index 100%
rename from testcases/kernel/syscalls/ipc/lib/ipcshm.h
rename to include/ipcshm.h
diff --git a/testcases/kernel/syscalls/ipc/lib/libmsgctl.h b/include/libmsgctl.h
similarity index 100%
rename from testcases/kernel/syscalls/ipc/lib/libmsgctl.h
rename to include/libmsgctl.h
diff --git a/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.h b/include/libnewipc.h
similarity index 98%
rename from testcases/kernel/syscalls/ipc/libnewipc/libnewipc.h
rename to include/libnewipc.h
index 660be8088053..30288cd68ca6 100644
--- a/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.h
+++ b/include/libnewipc.h
@@ -22,6 +22,8 @@
 #ifndef __LIBNEWIPC_H
 #define __LIBNEWIPC_H	1
 
+#include <sys/types.h>
+
 #define MSG_RD	0400
 #define MSG_WR	0200
 #define MSG_RW	(MSG_RD | MSG_WR)
diff --git a/testcases/kernel/syscalls/ipc/lib/Makefile b/libs/libltpipc/Makefile
similarity index 63%
rename from testcases/kernel/syscalls/ipc/lib/Makefile
rename to libs/libltpipc/Makefile
index 19916fa05003..11f38ea0a2a9 100644
--- a/testcases/kernel/syscalls/ipc/lib/Makefile
+++ b/libs/libltpipc/Makefile
@@ -1,10 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) International Business Machines  Corp., 2001
 
-top_srcdir		?= ../../../../..
+top_srcdir		?= ../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-LIB			:= libipc.a libmsgctl.a
+LIB			:= libltpipc.a libltpmsgctl.a
 
 include $(top_srcdir)/include/mk/lib.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/lib/libipc.c b/libs/libltpipc/libipc.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/lib/libipc.c
rename to libs/libltpipc/libipc.c
diff --git a/testcases/kernel/syscalls/ipc/lib/libmsgctl.c b/libs/libltpipc/libmsgctl.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/lib/libmsgctl.c
rename to libs/libltpipc/libmsgctl.c
diff --git a/testcases/kernel/syscalls/ipc/libnewipc/Makefile b/libs/libltpnewipc/Makefile
similarity index 63%
rename from testcases/kernel/syscalls/ipc/libnewipc/Makefile
rename to libs/libltpnewipc/Makefile
index d150fb70f6e8..741c78f81c89 100644
--- a/testcases/kernel/syscalls/ipc/libnewipc/Makefile
+++ b/libs/libltpnewipc/Makefile
@@ -1,10 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2016 Xiao Yang <yangx.jy@cn.fujitsu.com>
 
-top_srcdir		?= ../../../../..
+top_srcdir		?= ../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-INTERNAL_LIB		:= libnewipc.a
+INTERNAL_LIB		:= libltpnewipc.a
 
 include $(top_srcdir)/include/mk/lib.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.c b/libs/libltpnewipc/libnewipc.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/libnewipc/libnewipc.c
rename to libs/libltpnewipc/libnewipc.c
diff --git a/testcases/kernel/syscalls/ipc/Makefile b/testcases/kernel/syscalls/ipc/Makefile
index 9025a70f0609..7876f4bbd307 100644
--- a/testcases/kernel/syscalls/ipc/Makefile
+++ b/testcases/kernel/syscalls/ipc/Makefile
@@ -4,26 +4,4 @@
 top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
-
-LIBDIR			:= lib
-LIBNEWDIR		:= libnewipc
-FILTER_OUT_DIRS		:= $(LIBDIR) $(LIBNEWDIR)
-LIB			:= $(LIBDIR)/libipc.a $(LIBDIR)/libmsgctl.a
-
-$(LIBDIR):
-	mkdir -p "$@"
-
-$(LIB): $(LIBDIR)
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
-
-MAKE_DEPS		:= $(LIB)
-
-trunk-clean:: | lib-clean libnew-clean
-
-lib-clean:: $(LIBDIR)
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
-
-libnew-clean:: $(LIBNEWDIR)
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
-
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/syscalls/ipc/Makefile.inc b/testcases/kernel/syscalls/ipc/Makefile.inc
deleted file mode 100644
index c7e82bb18401..000000000000
--- a/testcases/kernel/syscalls/ipc/Makefile.inc
+++ /dev/null
@@ -1,28 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-or-later
-#    kernel/syscalls/ipc testcase suite common definitions Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-# Ngie Cooper, July 2009
-#
-
-# DO NOT USE THIS FILE FOR ipc / lib!!!
-
-LDLIBS			+= -lipc
-LIBDIR			:= ../lib
-
-LIBIPC			:= $(LIBDIR)/libipc.a
-
-$(LIBDIR):
-	mkdir -p "$@"
-
-$(LIBIPC): $(LIBDIR)
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
-
-MAKE_DEPS		:= $(LIBIPC)
-
-CPPFLAGS		+= -I$(abs_srcdir)/$(LIBDIR)
-
-LDFLAGS			+= -L$(abs_builddir)/$(LIBDIR)
-
-# vim: syntax=make
diff --git a/testcases/kernel/syscalls/ipc/Makefile2.inc b/testcases/kernel/syscalls/ipc/Makefile2.inc
deleted file mode 100644
index 17917f5f8964..000000000000
--- a/testcases/kernel/syscalls/ipc/Makefile2.inc
+++ /dev/null
@@ -1,22 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-or-later
-#    kernel/syscalls/ipc testcase suite common definitions Makefile.
-#
-#    Copyright (C) 2016, Cyril Hrubis
-#
-
-LDLIBS			+= -lnewipc
-LIBDIR			:= ../libnewipc
-
-LIBIPC			:= $(LIBDIR)/libnewipc.a
-
-$(LIBDIR):
-	mkdir -p "$@"
-
-$(LIBIPC): $(LIBDIR)
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
-
-MAKE_DEPS		:= $(LIBIPC)
-
-CPPFLAGS		+= -I$(abs_srcdir)/$(LIBDIR)
-
-LDFLAGS			+= -L$(abs_builddir)/$(LIBDIR)
diff --git a/testcases/kernel/syscalls/ipc/msgctl/Makefile b/testcases/kernel/syscalls/ipc/msgctl/Makefile
index 5e4c695dd310..e2b305573247 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/Makefile
+++ b/testcases/kernel/syscalls/ipc/msgctl/Makefile
@@ -4,5 +4,8 @@
 top_srcdir              ?= ../../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile2.inc
+
+LDLIBS  += -lltpnewipc
+LDFLAGS += -L$(top_builddir)/libs/libltpnewipc
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/msgget/Makefile b/testcases/kernel/syscalls/ipc/msgget/Makefile
index 5e4c695dd310..e2b305573247 100644
--- a/testcases/kernel/syscalls/ipc/msgget/Makefile
+++ b/testcases/kernel/syscalls/ipc/msgget/Makefile
@@ -4,5 +4,8 @@
 top_srcdir              ?= ../../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile2.inc
+
+LDLIBS  += -lltpnewipc
+LDFLAGS += -L$(top_builddir)/libs/libltpnewipc
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/Makefile b/testcases/kernel/syscalls/ipc/msgrcv/Makefile
index 401e5e8cbb9f..aa211d37f8ee 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/Makefile
+++ b/testcases/kernel/syscalls/ipc/msgrcv/Makefile
@@ -4,5 +4,8 @@
 top_srcdir              ?= ../../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile.inc
+
+LDLIBS  += -lltpipc
+LDFLAGS += -L$(top_builddir)/libs/libltpipc
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c
index 375d262bcdae..3e89a7f90376 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c
@@ -181,7 +181,7 @@ void setup(void)
 	/*
 	 * Create a temporary directory and cd into it.
 	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
+	 * See libs/libltpipc/libipc.c for more information.
 	 */
 	tst_tmpdir();
 
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c
index e42cf1f1323d..52cffeaf4e4c 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c
@@ -159,7 +159,7 @@ void setup(void)
 	/*
 	 * Create a temporary directory and cd into it.
 	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
+	 * See libs/libltpipc/libipc.c for more information.
 	 */
 	tst_tmpdir();
 
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv03.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv03.c
index 762b4d51bced..a81f7436dd98 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv03.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv03.c
@@ -136,7 +136,7 @@ void setup(void)
 	/*
 	 * Create a temporary directory and cd into it.
 	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
+	 * See libs/libltpipc/libipc.c for more information.
 	 */
 	tst_tmpdir();
 
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv04.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv04.c
index 833ad1aec066..573059c35d13 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv04.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv04.c
@@ -147,7 +147,7 @@ void setup(void)
 	/*
 	 * Create a temporary directory and cd into it.
 	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
+	 * See libs/libltpipc/libipc.c for more information.
 	 */
 	tst_tmpdir();
 
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv05.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv05.c
index 66c4341f1aee..4c7a446e79f1 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv05.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv05.c
@@ -181,7 +181,7 @@ void setup(void)
 	/*
 	 * Create a temporary directory and cd into it.
 	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
+	 * See libs/libltpipc/libipc.c for more information.
 	 */
 	tst_tmpdir();
 
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv06.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv06.c
index a27d093bed80..e3458b9ad0d7 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv06.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv06.c
@@ -202,7 +202,7 @@ void setup(void)
 	/*
 	 * Create a temporary directory and cd into it.
 	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
+	 * See libs/libltpipc/libipc.c for more information.
 	 */
 	tst_tmpdir();
 }
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/Makefile b/testcases/kernel/syscalls/ipc/msgsnd/Makefile
index 46f6f108535e..b4930310fc63 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/Makefile
+++ b/testcases/kernel/syscalls/ipc/msgsnd/Makefile
@@ -8,5 +8,8 @@ FILTER_OUT_MAKE_TARGETS += msgsnd05 msgsnd06
 endif
 
 include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile2.inc
+
+LDLIBS  += -lltpnewipc
+LDFLAGS += -L$(top_builddir)/libs/libltpnewipc
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/msgstress/Makefile b/testcases/kernel/syscalls/ipc/msgstress/Makefile
index c62bf4131063..5514638297ed 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/Makefile
+++ b/testcases/kernel/syscalls/ipc/msgstress/Makefile
@@ -5,10 +5,8 @@ top_srcdir              ?= ../../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-LIBMSGCTL               := $(LIBDIR)/libmsgctl.a
-LDLIBS                  += -lmsgctl
+LDLIBS  += -lltpipc
+LDLIBS  += -lltpmsgctl
+LDFLAGS += -L$(top_builddir)/libs/libltpipc
 
-MAKE_DEPS               := $(LIBMSGCTL)
-
-include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
index 7117e38311c4..0a660c042e95 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
@@ -39,7 +39,7 @@
 #include <sys/msg.h>
 #include "test.h"
 #include "ipcmsg.h"
-#include "../lib/libmsgctl.h"
+#include "libmsgctl.h"
 
 char *TCID = "msgstress01";
 int TST_TOTAL = 1;
diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress02.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress02.c
index 43982bdc20f8..e151310436cb 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress02.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress02.c
@@ -37,7 +37,7 @@
 #include <unistd.h>
 #include "test.h"
 #include "ipcmsg.h"
-#include "../lib/libmsgctl.h"
+#include "libmsgctl.h"
 
 char *TCID = "msgstress02";
 int TST_TOTAL = 1;
diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c
index de4b459a1df7..294b401b1b38 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c
@@ -40,7 +40,7 @@
 #include <sys/msg.h>
 #include "test.h"
 #include "ipcmsg.h"
-#include "../lib/libmsgctl.h"
+#include "libmsgctl.h"
 
 char *TCID = "msgstress03";
 int TST_TOTAL = 1;
diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
index 81383d6c8b11..f1c124990cb1 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
@@ -38,7 +38,7 @@
 #include <unistd.h>
 #include "test.h"
 #include "ipcmsg.h"
-#include "../lib/libmsgctl.h"
+#include "libmsgctl.h"
 
 char *TCID = "msgstress04";
 int TST_TOTAL = 1;
diff --git a/testcases/kernel/syscalls/ipc/semctl/Makefile b/testcases/kernel/syscalls/ipc/semctl/Makefile
index 401e5e8cbb9f..aa211d37f8ee 100644
--- a/testcases/kernel/syscalls/ipc/semctl/Makefile
+++ b/testcases/kernel/syscalls/ipc/semctl/Makefile
@@ -4,5 +4,8 @@
 top_srcdir              ?= ../../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile.inc
+
+LDLIBS  += -lltpipc
+LDFLAGS += -L$(top_builddir)/libs/libltpipc
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl02.c b/testcases/kernel/syscalls/ipc/semctl/semctl02.c
index 1fcdd1dc6074..35051f62c196 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl02.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl02.c
@@ -130,7 +130,7 @@ void setup(void)
 	/*
 	 * Create a temporary directory and cd into it.
 	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
+	 * See libs/libltpipc/libipc.c for more information.
 	 */
 	tst_tmpdir();
 
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl03.c b/testcases/kernel/syscalls/ipc/semctl/semctl03.c
index c1006509e484..dc851bfd6fbd 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl03.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl03.c
@@ -147,7 +147,7 @@ void setup(void)
 	/*
 	 * Create a temporary directory and cd into it.
 	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
+	 * See libs/libltpipc/libipc.c for more information.
 	 */
 	tst_tmpdir();
 
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl04.c b/testcases/kernel/syscalls/ipc/semctl/semctl04.c
index a08db1c5c94a..b1f199e6050f 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl04.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl04.c
@@ -174,7 +174,7 @@ void setup(void)
 	/*
 	 * Create a temporary directory and cd into it.
 	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
+	 * See libs/libltpipc/libipc.c for more information.
 	 */
 	tst_tmpdir();
 
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl05.c b/testcases/kernel/syscalls/ipc/semctl/semctl05.c
index 865305484fd1..84dace404083 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl05.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl05.c
@@ -150,7 +150,7 @@ void setup(void)
 	/*
 	 * Create a temporary directory and cd into it.
 	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
+	 * See libs/libltpipc/libipc.c for more information.
 	 */
 	tst_tmpdir();
 
diff --git a/testcases/kernel/syscalls/ipc/semget/Makefile b/testcases/kernel/syscalls/ipc/semget/Makefile
index 401e5e8cbb9f..aa211d37f8ee 100644
--- a/testcases/kernel/syscalls/ipc/semget/Makefile
+++ b/testcases/kernel/syscalls/ipc/semget/Makefile
@@ -4,5 +4,8 @@
 top_srcdir              ?= ../../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile.inc
+
+LDLIBS  += -lltpipc
+LDFLAGS += -L$(top_builddir)/libs/libltpipc
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/semget/semget01.c b/testcases/kernel/syscalls/ipc/semget/semget01.c
index a6cdd2d20ab7..217163b3af20 100644
--- a/testcases/kernel/syscalls/ipc/semget/semget01.c
+++ b/testcases/kernel/syscalls/ipc/semget/semget01.c
@@ -56,7 +56,7 @@
  *	none
  */
 
-#include "../lib/ipcsem.h"
+#include "ipcsem.h"
 
 char *TCID = "semget01";
 int TST_TOTAL = 1;
@@ -150,7 +150,7 @@ void setup(void)
 	/*
 	 * Create a temporary directory and cd into it.
 	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
+	 * See libs/libltpipc/libipc.c for more information.
 	 */
 	tst_tmpdir();
 
diff --git a/testcases/kernel/syscalls/ipc/semget/semget02.c b/testcases/kernel/syscalls/ipc/semget/semget02.c
index af7797189a45..4124514c2963 100644
--- a/testcases/kernel/syscalls/ipc/semget/semget02.c
+++ b/testcases/kernel/syscalls/ipc/semget/semget02.c
@@ -51,7 +51,7 @@
  */
 #include <pwd.h>
 
-#include "../lib/ipcsem.h"
+#include "ipcsem.h"
 
 char *TCID = "semget02";
 int TST_TOTAL = 2;
@@ -138,7 +138,7 @@ void setup(void)
 	/*
 	 * Create a temporary directory and cd into it.
 	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
+	 * See libs/libltpipc/libipc.c for more information.
 	 */
 	tst_tmpdir();
 
diff --git a/testcases/kernel/syscalls/ipc/semget/semget03.c b/testcases/kernel/syscalls/ipc/semget/semget03.c
index 976c78a521b9..995b4bd3add7 100644
--- a/testcases/kernel/syscalls/ipc/semget/semget03.c
+++ b/testcases/kernel/syscalls/ipc/semget/semget03.c
@@ -50,7 +50,7 @@
  *	none
  */
 
-#include "../lib/ipcsem.h"
+#include "ipcsem.h"
 
 char *TCID = "semget03";
 int TST_TOTAL = 1;
@@ -111,7 +111,7 @@ void setup(void)
 	/*
 	 * Create a temporary directory and cd into it.
 	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
+	 * See libs/libltpipc/libipc.c for more information.
 	 */
 	tst_tmpdir();
 
diff --git a/testcases/kernel/syscalls/ipc/semget/semget05.c b/testcases/kernel/syscalls/ipc/semget/semget05.c
index 976769619c1e..f801cb8ed53a 100644
--- a/testcases/kernel/syscalls/ipc/semget/semget05.c
+++ b/testcases/kernel/syscalls/ipc/semget/semget05.c
@@ -48,7 +48,7 @@
  *	none
  */
 
-#include "../lib/ipcsem.h"
+#include "ipcsem.h"
 
 char *TCID = "semget05";
 int TST_TOTAL = 1;
diff --git a/testcases/kernel/syscalls/ipc/semget/semget06.c b/testcases/kernel/syscalls/ipc/semget/semget06.c
index 858006d80dd6..52297c010092 100644
--- a/testcases/kernel/syscalls/ipc/semget/semget06.c
+++ b/testcases/kernel/syscalls/ipc/semget/semget06.c
@@ -50,7 +50,7 @@
  *	none
  */
 
-#include "../lib/ipcsem.h"
+#include "ipcsem.h"
 
 char *TCID = "semget06";
 int TST_TOTAL = 2;
@@ -121,7 +121,7 @@ void setup(void)
 	/*
 	 * Create a temporary directory and cd into it.
 	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
+	 * See libs/libltpipc/libipc.c for more information.
 	 */
 	tst_tmpdir();
 
diff --git a/testcases/kernel/syscalls/ipc/semop/Makefile b/testcases/kernel/syscalls/ipc/semop/Makefile
index 401e5e8cbb9f..aa211d37f8ee 100644
--- a/testcases/kernel/syscalls/ipc/semop/Makefile
+++ b/testcases/kernel/syscalls/ipc/semop/Makefile
@@ -4,5 +4,8 @@
 top_srcdir              ?= ../../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile.inc
+
+LDLIBS  += -lltpipc
+LDFLAGS += -L$(top_builddir)/libs/libltpipc
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/semop/semop03.c b/testcases/kernel/syscalls/ipc/semop/semop03.c
index a904e99439e2..9c1c58202ad3 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop03.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop03.c
@@ -130,7 +130,7 @@ void setup(void)
 	/*
 	 * Create a temporary directory and cd into it.
 	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
+	 * See libs/libltpipc/libipc.c for more information.
 	 */
 	tst_tmpdir();
 
diff --git a/testcases/kernel/syscalls/ipc/semop/semop04.c b/testcases/kernel/syscalls/ipc/semop/semop04.c
index bf425b54bb4c..c1fa2eba7584 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop04.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop04.c
@@ -148,7 +148,7 @@ void setup(void)
 	/*
 	 * Create a temporary directory and cd into it.
 	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
+	 * See libs/libltpipc/libipc.c for more information.
 	 */
 	tst_tmpdir();
 
diff --git a/testcases/kernel/syscalls/ipc/semop/semop05.c b/testcases/kernel/syscalls/ipc/semop/semop05.c
index 6ed25014c7af..e97ad42fe01d 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop05.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop05.c
@@ -256,7 +256,7 @@ void setup(void)
 	/*
 	 * Create a temporary directory and cd into it.
 	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
+	 * See libs/libltpipc/libipc.c for more information.
 	 */
 	tst_tmpdir();
 
diff --git a/testcases/kernel/syscalls/ipc/shmat/Makefile b/testcases/kernel/syscalls/ipc/shmat/Makefile
index 5e4c695dd310..e2b305573247 100644
--- a/testcases/kernel/syscalls/ipc/shmat/Makefile
+++ b/testcases/kernel/syscalls/ipc/shmat/Makefile
@@ -4,5 +4,8 @@
 top_srcdir              ?= ../../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile2.inc
+
+LDLIBS  += -lltpnewipc
+LDFLAGS += -L$(top_builddir)/libs/libltpnewipc
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/shmctl/Makefile b/testcases/kernel/syscalls/ipc/shmctl/Makefile
index 77cba6c335d0..dda6d636f755 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/Makefile
+++ b/testcases/kernel/syscalls/ipc/shmctl/Makefile
@@ -7,5 +7,8 @@ shmctl05: CFLAGS += -pthread
 shmctl05: LDLIBS += -lrt
 
 include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile.inc
+
+LDLIBS  += -lltpipc
+LDFLAGS += -L$(top_builddir)/libs/libltpipc
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
index 563f6870ade8..0b97bb240f02 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
@@ -174,7 +174,7 @@ void setup(void)
 	/*
 	 * Create a temporary directory and cd into it.
 	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
+	 * See libs/libltpipc/libipc.c for more information.
 	 */
 	tst_tmpdir();
 
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
index 97cf27baf14c..798eadad6549 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
@@ -176,7 +176,7 @@ void setup(void)
 	/*
 	 * Create a temporary directory and cd into it.
 	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
+	 * See libs/libltpipc/libipc.c for more information.
 	 */
 	tst_tmpdir();
 
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
index c9d13d46e571..40cfa9419f65 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
@@ -97,7 +97,7 @@ void setup(void)
 	/*
 	 * Create a temporary directory and cd into it.
 	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
+	 * See libs/libltpipc/libipc.c for more information.
 	 */
 	tst_tmpdir();
 
diff --git a/testcases/kernel/syscalls/ipc/shmdt/Makefile b/testcases/kernel/syscalls/ipc/shmdt/Makefile
index 401e5e8cbb9f..aa211d37f8ee 100644
--- a/testcases/kernel/syscalls/ipc/shmdt/Makefile
+++ b/testcases/kernel/syscalls/ipc/shmdt/Makefile
@@ -4,5 +4,8 @@
 top_srcdir              ?= ../../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile.inc
+
+LDLIBS  += -lltpipc
+LDFLAGS += -L$(top_builddir)/libs/libltpipc
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/shmdt/shmdt01.c b/testcases/kernel/syscalls/ipc/shmdt/shmdt01.c
index fc167e7fd8d1..697613a47c12 100644
--- a/testcases/kernel/syscalls/ipc/shmdt/shmdt01.c
+++ b/testcases/kernel/syscalls/ipc/shmdt/shmdt01.c
@@ -184,7 +184,7 @@ void setup(void)
 	/*
 	 * Create a temporary directory and cd into it.
 	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
+	 * See libs/libltpipc/libipc.c for more information.
 	 */
 	tst_tmpdir();
 
diff --git a/testcases/kernel/syscalls/ipc/shmget/Makefile b/testcases/kernel/syscalls/ipc/shmget/Makefile
index 401e5e8cbb9f..aa211d37f8ee 100644
--- a/testcases/kernel/syscalls/ipc/shmget/Makefile
+++ b/testcases/kernel/syscalls/ipc/shmget/Makefile
@@ -4,5 +4,8 @@
 top_srcdir              ?= ../../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile.inc
+
+LDLIBS  += -lltpipc
+LDFLAGS += -L$(top_builddir)/libs/libltpipc
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget01.c b/testcases/kernel/syscalls/ipc/shmget/shmget01.c
index ae63baf6fe6c..586f4c263934 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget01.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget01.c
@@ -149,7 +149,7 @@ void setup(void)
 	/*
 	 * Create a temporary directory and cd into it.
 	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
+	 * See libs/libltpipc/libipc.c for more information.
 	 */
 	tst_tmpdir();
 
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget02.c b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
index 71d161614afa..4436ca7f8492 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget02.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
@@ -144,7 +144,7 @@ void setup(void)
 	/*
 	 * Create a temporary directory and cd into it.
 	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
+	 * See libs/libltpipc/libipc.c for more information.
 	 */
 	tst_tmpdir();
 
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget03.c b/testcases/kernel/syscalls/ipc/shmget/shmget03.c
index b9ff1a4e6572..96ebf3608a6d 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget03.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget03.c
@@ -123,7 +123,7 @@ void setup(void)
 	/*
 	 * Create a temporary directory and cd into it.
 	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
+	 * See libs/libltpipc/libipc.c for more information.
 	 */
 	tst_tmpdir();
 
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget04.c b/testcases/kernel/syscalls/ipc/shmget/shmget04.c
index b0cff30569d7..60a263c77687 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget04.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget04.c
@@ -125,7 +125,7 @@ void setup(void)
 	/*
 	 * Create a temporary directory and cd into it.
 	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
+	 * See libs/libltpipc/libipc.c for more information.
 	 */
 	tst_tmpdir();
 
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget05.c b/testcases/kernel/syscalls/ipc/shmget/shmget05.c
index 01770ba7da0a..de9544591b74 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget05.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget05.c
@@ -157,7 +157,7 @@ void setup(void)
 	/*
 	 * Create a temporary directory and cd into it.
 	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
+	 * See libs/libltpipc/libipc.c for more information.
 	 */
 	tst_tmpdir();
 
diff --git a/testcases/kernel/syscalls/kill/Makefile b/testcases/kernel/syscalls/kill/Makefile
index a6577183b2bb..3e32978fc86a 100644
--- a/testcases/kernel/syscalls/kill/Makefile
+++ b/testcases/kernel/syscalls/kill/Makefile
@@ -5,22 +5,7 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-LDLIBS                  += -lipc
-
-LIBDIR			:= ../ipc/lib
-
-LIB                     := $(LIBDIR)/libipc.a
-
-$(LIBDIR):
-	mkdir -p "$@"
-
-$(LIB): $(LIBDIR)
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
-
-MAKE_DEPS		:= $(LIB)
-
-CPPFLAGS                += -I$(abs_srcdir)/$(LIBDIR)
-
-LDFLAGS                 += -L$(abs_builddir)/$(LIBDIR)
+LDLIBS  += -lltpipc
+LDFLAGS += -L$(top_builddir)/libs/libltpipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/kill/kill07.c b/testcases/kernel/syscalls/kill/kill07.c
index 60904dd2b16d..c566a0a09589 100644
--- a/testcases/kernel/syscalls/kill/kill07.c
+++ b/testcases/kernel/syscalls/kill/kill07.c
@@ -214,7 +214,7 @@ void setup(void)
 	/*
 	 * Create a temporary directory and cd into it.
 	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
+	 * See libs/libltpipc/libipc.c for more information.
 	 */
 	tst_tmpdir();
 
diff --git a/testcases/kernel/syscalls/mremap/Makefile b/testcases/kernel/syscalls/mremap/Makefile
index 16ebb64df820..3e32978fc86a 100644
--- a/testcases/kernel/syscalls/mremap/Makefile
+++ b/testcases/kernel/syscalls/mremap/Makefile
@@ -5,22 +5,7 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-LDLIBS			+= -lipc
-
-LIBDIR			:= ../ipc/lib
-
-LIB                     := $(LIBDIR)/libipc.a
-
-$(LIBDIR):
-	mkdir -p "$@"
-
-$(LIB): $(LIBDIR)
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
-
-MAKE_DEPS		:= $(LIB)
-
-CPPFLAGS                += -I$(abs_srcdir)/$(LIBDIR)
-
-LDFLAGS                 += -L$(abs_builddir)/$(LIBDIR)
+LDLIBS  += -lltpipc
+LDFLAGS += -L$(top_builddir)/libs/libltpipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.25.0.rc1.19.g042ed3e048af

