From: Greg Hackmann <ghackmann@google.com>
Date: Tue,  4 Dec 2018 10:23:53 -0800
Subject: [LTP] [PATCH] cve/stack_clash: inhibit test-breaking optimizations
Message-ID: <20181204182353.86453-1-ghackmann@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

stack_clash relies on the compiler doing fairly specific things with the
stack pointer.  We've run into a couple of places where clang optimized
away the intended behavior:

(1) exhaust_stack_into_sigsegv() tries to grow the stack via infinite
recursion.  Since this happens through a tail call, the compiler may
transform this into an iterative equivalent which loops forever without
growing the stack.  -fno-optimize-sibling-calls explicitly blocks this
optimization on both gcc and clang.

(2) If preallocate_stack() is inlined, its ~1 MB stack frame may not be
released until the parent function returns.  This can cause the stack
pointer to cross the stack guard in the middle of do_child(), before the
SIGSEGV handler has actually been set up.  Prevent this by marking the
function noinline.

Signed-off-by: Greg Hackmann <ghackmann@google.com>
---
 testcases/cve/Makefile      | 2 ++
 testcases/cve/stack_clash.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/cve/Makefile b/testcases/cve/Makefile
index 3a05dd4fe..6dc401cff 100644
--- a/testcases/cve/Makefile
+++ b/testcases/cve/Makefile
@@ -19,6 +19,8 @@ include $(top_srcdir)/include/mk/testcases.mk
 
 CFLAGS			+= -D_GNU_SOURCE
 
+stack_clash:	CFLAGS += -fno-optimize-sibling-calls
+
 cve-2016-7042:	LDLIBS += $(KEYUTILS_LIBS)
 
 cve-2016-7117:	CFLAGS += -pthread
diff --git a/testcases/cve/stack_clash.c b/testcases/cve/stack_clash.c
index f25e19b3f..ac4a31af6 100644
--- a/testcases/cve/stack_clash.c
+++ b/testcases/cve/stack_clash.c
@@ -136,7 +136,7 @@ void dump_proc_self_maps(void)
 	tst_run_cmd(cmd, NULL, NULL, 0);
 }
 
-void preallocate_stack(unsigned long required)
+void __attribute__((noinline)) preallocate_stack(unsigned long required)
 {
 	volatile char *garbage;
 
-- 
2.20.0.rc1.387.gf8505762e3-goog

