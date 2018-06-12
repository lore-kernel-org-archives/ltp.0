From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 12 Jun 2018 17:46:31 +0200
Subject: [LTP] [RFC PATCH 9/9] syscalls/ipc: Fix Makefile
In-Reply-To: <20180612154631.435-1-chrubis@suse.cz>
References: <20180612154631.435-1-chrubis@suse.cz>
Message-ID: <20180612154631.435-10-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Switch to new ipc library now that all testcases are rewritten.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/ipc/msgctl/Makefile | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgctl/Makefile b/testcases/kernel/syscalls/ipc/msgctl/Makefile
index 4472eeb1c..f9ee8d2c2 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/Makefile
+++ b/testcases/kernel/syscalls/ipc/msgctl/Makefile
@@ -19,11 +19,5 @@
 top_srcdir              ?= ../../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-
-LIBMSGCTL               := $(LIBDIR)/libmsgctl.a
-LDLIBS                  += -lmsgctl
-
-MAKE_DEPS               := $(LIBMSGCTL)
-
-include $(abs_srcdir)/../Makefile.inc
+include $(abs_srcdir)/../Makefile2.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.13.6

