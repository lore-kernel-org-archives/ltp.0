From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 18 Oct 2017 13:10:57 +0200
Subject: [LTP] [PATCH v5 03/12] make: Remove workarounds for build without
	libnuma
In-Reply-To: <20171018111106.17215-1-pvorel@suse.cz>
References: <20171018111106.17215-1-pvorel@suse.cz>
Message-ID: <20171018111106.17215-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/mbind/Makefile         | 9 ---------
 testcases/kernel/syscalls/migrate_pages/Makefile | 3 ---
 testcases/kernel/syscalls/move_pages/Makefile    | 5 -----
 3 files changed, 17 deletions(-)

diff --git a/testcases/kernel/syscalls/mbind/Makefile b/testcases/kernel/syscalls/mbind/Makefile
index 5132dffa4..1e2f5e4de 100644
--- a/testcases/kernel/syscalls/mbind/Makefile
+++ b/testcases/kernel/syscalls/mbind/Makefile
@@ -20,15 +20,6 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-#
-# gcc complains about unused functions / variables when HAS_NUMA_H isn't
-# defined, so let's just skip the warning. It's nothing more than a few extra
-# variables and functions allocated on the stack, so meh... no harm, no foul.
-#
-ifeq ($(NUMA_LIBS),)
-CPPFLAGS		+= -Wno-unused
-endif
-
 CPPFLAGS		+= -I$(abs_srcdir)/../utils/
 
 include $(top_srcdir)/testcases/kernel/include/lib.mk
diff --git a/testcases/kernel/syscalls/migrate_pages/Makefile b/testcases/kernel/syscalls/migrate_pages/Makefile
index 7168cd6e1..46a35d3e0 100644
--- a/testcases/kernel/syscalls/migrate_pages/Makefile
+++ b/testcases/kernel/syscalls/migrate_pages/Makefile
@@ -23,9 +23,6 @@ include $(top_srcdir)/include/mk/testcases.mk
 MAKE_TARGETS		:= $(patsubst $(abs_srcdir)/%.c,%,$(wildcard $(abs_srcdir)/*[0-9].c))
 $(MAKE_TARGETS): %: %.o migrate_pages_common.o
 
-ifeq ($(NUMA_LIBS),)
-CPPFLAGS		+= -Wno-unused
-endif
 CPPFLAGS		+= -I$(abs_srcdir)/../utils/
 
 include $(top_srcdir)/testcases/kernel/include/lib.mk
diff --git a/testcases/kernel/syscalls/move_pages/Makefile b/testcases/kernel/syscalls/move_pages/Makefile
index d4620e10a..989277019 100644
--- a/testcases/kernel/syscalls/move_pages/Makefile
+++ b/testcases/kernel/syscalls/move_pages/Makefile
@@ -26,11 +26,6 @@ INSTALL_TARGETS		:= move_pages.sh
 
 MAKE_TARGETS		:= $(patsubst $(abs_srcdir)/%.c,%,$(wildcard $(abs_srcdir)/*[0-9].c))
 
-# linux_syscall_numbers.h is forcing move_pages_support.o to complain about
-# cleanup being undefined [and when defined] unused. Let's just skip this
-# warning...
-move_pages_support.o: CFLAGS += -Wno-unused-function
-
 $(MAKE_TARGETS): %: %.o move_pages_support.o
 
 LDLIBS			+= -lpthread -lrt
-- 
2.14.2

