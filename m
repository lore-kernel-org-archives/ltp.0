From: Martin Doucha <mdoucha@suse.cz>
Date: Mon,  9 Nov 2020 17:46:05 +0100
Subject: [LTP] [PATCH v3 2/2] syscalls/iopl,
 ioperm: Check for SecureBoot lockdown
In-Reply-To: <20201109164605.25965-1-mdoucha@suse.cz>
References: <20201109164605.25965-1-mdoucha@suse.cz>
Message-ID: <20201109164605.25965-2-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

SecureBoot implies integrity lockdown even if tst_lockdown_enabled() cannot
check lockdown status directly. Udpate skip condition in ioperm() and iopl()
tests.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v2:
- new patch

 testcases/kernel/syscalls/ioperm/Makefile   | 3 +++
 testcases/kernel/syscalls/ioperm/ioperm01.c | 3 ++-
 testcases/kernel/syscalls/ioperm/ioperm02.c | 5 +++++
 testcases/kernel/syscalls/iopl/Makefile     | 3 +++
 testcases/kernel/syscalls/iopl/iopl01.c     | 3 ++-
 testcases/kernel/syscalls/iopl/iopl02.c     | 6 ++++++
 6 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/ioperm/Makefile b/testcases/kernel/syscalls/ioperm/Makefile
index 044619fb8..8624e2c99 100644
--- a/testcases/kernel/syscalls/ioperm/Makefile
+++ b/testcases/kernel/syscalls/ioperm/Makefile
@@ -5,4 +5,7 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
+CFLAGS			+= $(EFIVAR_CFLAGS)
+LDLIBS			+= $(EFIVAR_LIBS)
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ioperm/ioperm01.c b/testcases/kernel/syscalls/ioperm/ioperm01.c
index fc5754be9..01f83aefe 100644
--- a/testcases/kernel/syscalls/ioperm/ioperm01.c
+++ b/testcases/kernel/syscalls/ioperm/ioperm01.c
@@ -15,6 +15,7 @@
 #include <unistd.h>
 
 #include "tst_test.h"
+#include "tst_secureboot.h"
 
 #if defined __i386__ || defined(__x86_64__)
 #include <sys/io.h>
@@ -43,7 +44,7 @@ static void verify_ioperm(void)
 static void setup(void)
 {
 	/* ioperm() is restricted under kernel lockdown. */
-	if (tst_lockdown_enabled())
+	if (tst_lockdown_enabled() || tst_secureboot_enabled() > 0)
 		tst_brk(TCONF, "Kernel is locked down, skip this test");
 
 	/*
diff --git a/testcases/kernel/syscalls/ioperm/ioperm02.c b/testcases/kernel/syscalls/ioperm/ioperm02.c
index 1808191bf..129ca265c 100644
--- a/testcases/kernel/syscalls/ioperm/ioperm02.c
+++ b/testcases/kernel/syscalls/ioperm/ioperm02.c
@@ -22,6 +22,7 @@
 #include <pwd.h>
 #include "tst_test.h"
 #include "tst_safe_macros.h"
+#include "tst_secureboot.h"
 
 #if defined __i386__ || defined(__x86_64__)
 #include <sys/io.h>
@@ -45,6 +46,10 @@ static struct tcase_t {
 
 static void setup(void)
 {
+	/* ioperm() is restricted under kernel lockdown. */
+	if (tst_lockdown_enabled() || tst_secureboot_enabled() > 0)
+		tst_brk(TCONF, "Kernel is locked down, skip this test");
+
 	/*
 	 * The value of IO_BITMAP_BITS (include/asm-i386/processor.h) changed
 	 * from kernel 2.6.8 to permit 16-bits (65536) ioperm
diff --git a/testcases/kernel/syscalls/iopl/Makefile b/testcases/kernel/syscalls/iopl/Makefile
index 044619fb8..8624e2c99 100644
--- a/testcases/kernel/syscalls/iopl/Makefile
+++ b/testcases/kernel/syscalls/iopl/Makefile
@@ -5,4 +5,7 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
+CFLAGS			+= $(EFIVAR_CFLAGS)
+LDLIBS			+= $(EFIVAR_LIBS)
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/iopl/iopl01.c b/testcases/kernel/syscalls/iopl/iopl01.c
index dcf2cc406..60fc529e8 100644
--- a/testcases/kernel/syscalls/iopl/iopl01.c
+++ b/testcases/kernel/syscalls/iopl/iopl01.c
@@ -18,6 +18,7 @@
 #include <unistd.h>
 
 #include "tst_test.h"
+#include "tst_secureboot.h"
 
 #if defined __i386__ || defined(__x86_64__)
 #include <sys/io.h>
@@ -45,7 +46,7 @@ static void verify_iopl(void)
 static void setup(void)
 {
 	/* iopl() is restricted under kernel lockdown. */
-	if (tst_lockdown_enabled())
+	if (tst_lockdown_enabled() || tst_secureboot_enabled() > 0)
 		tst_brk(TCONF, "Kernel is locked down, skip this test");
 }
 
diff --git a/testcases/kernel/syscalls/iopl/iopl02.c b/testcases/kernel/syscalls/iopl/iopl02.c
index 6a817cf2d..f27cfd098 100644
--- a/testcases/kernel/syscalls/iopl/iopl02.c
+++ b/testcases/kernel/syscalls/iopl/iopl02.c
@@ -21,6 +21,7 @@
 #include <pwd.h>
 #include "tst_test.h"
 #include "tst_safe_macros.h"
+#include "tst_secureboot.h"
 
 #if defined __i386__ || defined(__x86_64__)
 #include <sys/io.h>
@@ -52,6 +53,11 @@ static void verify_iopl(unsigned int i)
 static void setup(void)
 {
 	struct passwd *pw;
+
+	/* ioperm() is restricted under kernel lockdown. */
+	if (tst_lockdown_enabled() || tst_secureboot_enabled() > 0)
+		tst_brk(TCONF, "Kernel is locked down, skip this test");
+
 	pw = SAFE_GETPWNAM("nobody");
 	SAFE_SETEUID(pw->pw_uid);
 }
-- 
2.28.0

