From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  9 Apr 2018 14:00:28 +0200
Subject: [LTP] [PATCH 1/1] utils/compat_16.mk: Further cleanup of unused
	sections and variables
Message-ID: <20180409120028.30692-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
-%_16.o: %.c $(COMPAT_16_H)
Is this make dependency for recompiling when header changes? It doesn't
behave like that but maybe I'm missing something.

Kind regards,
Petr
---
 testcases/kernel/syscalls/setuid/Makefile    |  3 ---
 testcases/kernel/syscalls/utils/compat_16.mk | 22 +---------------------
 2 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/testcases/kernel/syscalls/setuid/Makefile b/testcases/kernel/syscalls/setuid/Makefile
index 6bd943aaf..056bb9e80 100644
--- a/testcases/kernel/syscalls/setuid/Makefile
+++ b/testcases/kernel/syscalls/setuid/Makefile
@@ -19,8 +19,5 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-#for compat_16.mk uses the compat_16_tst.h
-COMPAT_TST_16_H		:= 1
-
 include $(abs_srcdir)/../utils/compat_16.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/utils/compat_16.mk b/testcases/kernel/syscalls/utils/compat_16.mk
index 0565ddefa..3dee0c230 100644
--- a/testcases/kernel/syscalls/utils/compat_16.mk
+++ b/testcases/kernel/syscalls/utils/compat_16.mk
@@ -56,28 +56,8 @@ MAKE_TARGETS		:= $(notdir $(patsubst %.c,%,$(SRCS)))
 MAKE_TARGETS_OBJS_WO_COMPAT_16	:= $(addsuffix .o,$(MAKE_TARGETS))
 MAKE_TARGETS		+= $(addsuffix _16,$(MAKE_TARGETS))
 
-# XXX (garrcoop): This code should be put in question as it cannot be applied
-# (no .h file, no TST_USE_NEWER64_SYSCALL def).
 DEF_16			:= TST_USE_COMPAT16_SYSCALL
-
-ifneq ($(COMPAT_TST_16_H),1)
-COMPAT_16_H		:= $(abs_srcdir)/../utils/compat_16.h
-else
-COMPAT_16_H     := $(abs_srcdir)/../utils/compat_tst_16.h
-endif
-
-ifneq ($(wildcard $(COMPAT_16_H)),)
-HAS_COMPAT_16		:= 1
-
-$(MAKE_TARGETS_OBJS_WO_COMPAT_16): $(COMPAT_16_H)
-.INTERMEDIATE: $(MAKE_TARGETS_OBJS_WO_COMPAT_16)
-
-else
-HAS_COMPAT_16		:= 0
-endif
-
 %_16: CPPFLAGS += -D$(DEF_16)=1
-# XXX (garrcoop): End section of code in question..
 
-%_16.o: %.c $(COMPAT_16_H)
+%_16.o: %.c
 	$(COMPILE.c) $(OUTPUT_OPTION) $<
-- 
2.16.3

