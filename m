From: Murphy Zhou <xzhou@redhat.com>
Date: Tue, 28 May 2019 22:12:14 +0800
Subject: [LTP] [PATCH v6 4/4] syscalls/swapoff/swapoff0{1,
	2}: use helper to check support status
In-Reply-To: <20190528141214.18752-1-xzhou@redhat.com>
References: <CAOQ4uxihom9Uw66c0BwuiWHOejZXDJHUe3rHBVRfk0=C-AYnAw@mail.gmail.com>
 <20190528141214.18752-1-xzhou@redhat.com>
Message-ID: <20190528141214.18752-4-xzhou@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Of swap operations. Change Makefile to use functions from
../swapon/libswapon.c

Signed-off-by: Murphy Zhou <xzhou@redhat.com>
---
 testcases/kernel/syscalls/swapoff/Makefile     |  3 ++-
 testcases/kernel/syscalls/swapoff/Makefile.inc |  6 ++++++
 testcases/kernel/syscalls/swapoff/swapoff01.c  | 10 ++--------
 testcases/kernel/syscalls/swapoff/swapoff02.c  |  9 +--------
 4 files changed, 11 insertions(+), 17 deletions(-)
 create mode 100644 testcases/kernel/syscalls/swapoff/Makefile.inc

diff --git a/testcases/kernel/syscalls/swapoff/Makefile b/testcases/kernel/syscalls/swapoff/Makefile
index bd617d806..536b2dbac 100644
--- a/testcases/kernel/syscalls/swapoff/Makefile
+++ b/testcases/kernel/syscalls/swapoff/Makefile
@@ -19,5 +19,6 @@
 top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-
+include $(abs_srcdir)/./Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
+$(MAKE_TARGETS): %: %.o ../swapon/libswapon.o
diff --git a/testcases/kernel/syscalls/swapoff/Makefile.inc b/testcases/kernel/syscalls/swapoff/Makefile.inc
new file mode 100644
index 000000000..65350cbeb
--- /dev/null
+++ b/testcases/kernel/syscalls/swapoff/Makefile.inc
@@ -0,0 +1,6 @@
+LIBDIR			+= ../swapon/
+LIBSWAPON		:= $(LIBDIR)/libswapon.o
+$(LIBSWAPON):
+	$(MAKE) -C $(LIBDIR)
+CPPFLAGS		+= -I$(abs_srcdir)/$(LIBDIR)
+LDFLAGS			+= -L$(abs_builddir)/$(LIBDIR)
diff --git a/testcases/kernel/syscalls/swapoff/swapoff01.c b/testcases/kernel/syscalls/swapoff/swapoff01.c
index a63e661a5..e115269c0 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff01.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff01.c
@@ -25,6 +25,7 @@
 #include <stdlib.h>
 #include "config.h"
 #include "lapi/syscalls.h"
+#include "../swapon/libswapon.h"
 
 static void setup(void);
 static void cleanup(void);
@@ -86,14 +87,7 @@ static void setup(void)
 
 	tst_tmpdir();
 
-	switch ((fs_type = tst_fs_type(cleanup, "."))) {
-	case TST_NFS_MAGIC:
-	case TST_TMPFS_MAGIC:
-		tst_brkm(TCONF, cleanup,
-			 "Cannot do swapoff on a file on %s filesystem",
-			 tst_fs_type_name(fs_type));
-	break;
-	}
+	is_swap_supported(cleanup, "./tstswap");
 
 	if (!tst_fs_has_free(NULL, ".", 64, TST_MB)) {
 		tst_brkm(TBROK, cleanup,
diff --git a/testcases/kernel/syscalls/swapoff/swapoff02.c b/testcases/kernel/syscalls/swapoff/swapoff02.c
index b5c6312a1..a59aaaa06 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff02.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff02.c
@@ -138,14 +138,7 @@ static void setup(void)
 
 	tst_tmpdir();
 
-	switch ((type = tst_fs_type(cleanup, "."))) {
-	case TST_NFS_MAGIC:
-	case TST_TMPFS_MAGIC:
-		tst_brkm(TCONF, cleanup,
-			 "Cannot do swapoff on a file on %s filesystem",
-			 tst_fs_type_name(type));
-	break;
-	}
+	is_swap_supported(cleanup, "./tstswap");
 
 	if (!tst_fs_has_free(NULL, ".", 1, TST_KB)) {
 		tst_brkm(TBROK, cleanup,
-- 
2.21.0

