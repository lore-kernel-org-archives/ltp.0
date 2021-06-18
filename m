From: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Fri, 18 Jun 2021 14:32:11 +0800
Subject: [LTP] [RFC] Makefile: simplify code
Message-ID: <1623997931-18117-1-git-send-email-xuyang2018.jy@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When these target use CFLAGS or LDLIBS, they can be in one line instead of separate lines.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 lib/newlib_tests/Makefile                  | 10 ++--------
 testcases/cve/Makefile                     | 13 ++-----------
 testcases/kernel/sound/Makefile            |  6 ++----
 testcases/kernel/syscalls/bind/Makefile    |  3 +--
 testcases/kernel/syscalls/futex/Makefile   | 11 ++---------
 testcases/kernel/syscalls/preadv2/Makefile |  3 +--
 6 files changed, 10 insertions(+), 36 deletions(-)

diff --git a/lib/newlib_tests/Makefile b/lib/newlib_tests/Makefile
index 30ca6810c..5bd68e95e 100644
--- a/lib/newlib_tests/Makefile
+++ b/lib/newlib_tests/Makefile
@@ -6,14 +6,8 @@ include $(top_srcdir)/include/mk/env_pre.mk
 CFLAGS			+= -W -Wall
 LDLIBS			+= -lltp
 
-test08: CFLAGS+=-pthread
-test09: CFLAGS+=-pthread
-test15: CFLAGS+=-pthread
-test16: CFLAGS+=-pthread
-test16: LDLIBS+=-lrt
-tst_expiration_timer: LDLIBS+=-lrt
-tst_fuzzy_sync01: CFLAGS+=-pthread
-tst_fuzzy_sync02: CFLAGS+=-pthread
+test08 test09 test15 test16 tst_fuzzy_sync01 tst_fuzzy_sync02: CFLAGS += -pthread
+test16 tst_expiration_timer: LDLIBS += -lrt
 
 ifeq ($(ANDROID),1)
 FILTER_OUT_MAKE_TARGETS	+= test08
diff --git a/testcases/cve/Makefile b/testcases/cve/Makefile
index 301e19461..ddf8b6fe1 100644
--- a/testcases/cve/Makefile
+++ b/testcases/cve/Makefile
@@ -11,28 +11,19 @@ stack_clash:	CFLAGS += -fno-optimize-sibling-calls
 
 cve-2016-7042:	LDLIBS += $(KEYUTILS_LIBS)
 
-cve-2016-7117:	CFLAGS += -pthread
-cve-2016-7117:	LDLIBS += -lrt
-
-cve-2014-0196:  CFLAGS += -pthread
-cve-2014-0196:  LDLIBS += -lrt
+cve-2014-0196 cve-2016-7117 cve-2017-2671 cve-2017-17052 cve-2017-17053:  CFLAGS += -pthread
+cve-2014-0196 cve-2016-7117 cve-2017-2671:  LDLIBS += -lrt
 
 ifneq ($(ANDROID),1)
 cve-2014-0196:  LDLIBS += -lutil
 endif
 
-cve-2017-2671:	CFLAGS += -pthread
-cve-2017-2671:	LDLIBS += -lrt
-
 meltdown: CFLAGS += -I$(abs_srcdir)/../realtime/include
 
 ifneq (,$(filter $(HOST_CPU),x86 x86_64))
 meltdown: CFLAGS += -msse2
 endif
 
-cve-2017-17052:	CFLAGS += -pthread
-cve-2017-17053:	CFLAGS += -pthread
-
 cve-2015-3290:	CFLAGS += -pthread -fomit-frame-pointer
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/sound/Makefile b/testcases/kernel/sound/Makefile
index 5c728ef36..04a7c077f 100644
--- a/testcases/kernel/sound/Makefile
+++ b/testcases/kernel/sound/Makefile
@@ -6,9 +6,7 @@ include $(top_srcdir)/include/mk/testcases.mk
 
 CPPFLAGS		+= -D_GNU_SOURCE
 
-snd_timer01: CFLAGS+=-pthread
-snd_timer01: LDLIBS+=-lrt
-snd_seq01:	CFLAGS += -pthread
-snd_seq01:	LDLIBS += -lrt
+snd_timer01 snd_seq01: CFLAGS += -pthread
+snd_timer01 snd_seq01: LDLIBS += -lrt
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/bind/Makefile b/testcases/kernel/syscalls/bind/Makefile
index 00db0e7ff..cc1d81423 100644
--- a/testcases/kernel/syscalls/bind/Makefile
+++ b/testcases/kernel/syscalls/bind/Makefile
@@ -5,8 +5,7 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-bind04 bind05:	CFLAGS		+= -pthread
-bind06: CFLAGS += -pthread
+bind04 bind05 bind06: CFLAGS += -pthread
 bind06: LDLIBS += -lrt
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/futex/Makefile b/testcases/kernel/syscalls/futex/Makefile
index c88af7c96..5713c615d 100644
--- a/testcases/kernel/syscalls/futex/Makefile
+++ b/testcases/kernel/syscalls/futex/Makefile
@@ -3,15 +3,8 @@
 
 top_srcdir		?= ../../../..
 
-futex_cmp_requeue01: LDLIBS+=-lrt
-futex_cmp_requeue02: LDLIBS+=-lrt
-futex_wait02: LDLIBS+=-lrt
-futex_wake03: LDLIBS+=-lrt
-futex_wait03: CFLAGS+=-pthread
-futex_wake02: CFLAGS+=-pthread
-futex_wake04: CFLAGS+=-pthread
-futex_wait05: LDLIBS+=-lrt
-futex_wait_bitset01: LDLIBS+=-lrt
+futex_cmp_requeue01 futex_cmp_requeue02 futex_wait02 futex_wake03 futex_wait05 futex_wait_bitset01: LDLIBS += -lrt
+futex_wait03 futex_wake02 futex_wake04: CFLAGS += -pthread
 
 include $(top_srcdir)/include/mk/testcases.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/preadv2/Makefile b/testcases/kernel/syscalls/preadv2/Makefile
index fbedd0287..d4f4f55be 100644
--- a/testcases/kernel/syscalls/preadv2/Makefile
+++ b/testcases/kernel/syscalls/preadv2/Makefile
@@ -11,8 +11,7 @@ include $(abs_srcdir)/../utils/newer_64.mk
 
 %_64: CPPFLAGS += -D_FILE_OFFSET_BITS=64
 
-preadv203: CFLAGS += -pthread
-preadv203_64: CFLAGS += -pthread
+preadv203 preadv203_64: CFLAGS += -pthread
 preadv203_64: LDFLAGS += -pthread
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.23.0

