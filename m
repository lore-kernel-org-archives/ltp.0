From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 10 Oct 2017 17:26:37 +0200
Subject: [LTP] [PATCH 1/1] syscalls/ustat: Fix build for libc without
	ustat() support
Message-ID: <20171010152637.11194-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This applies at least for uClibc/uClibc-ng with disabled __UCLIBC_SV4_DEPRECATED__.

Patch taken from buildroot project (thanks!), adjusted it not to be
only uClibc/uClibc-ng specific.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Reported-by: Erico Nunes <nunes.erico@gmail.com>
---
Another Buildroot patch, this one is hopefully correct.
---
 configure.ac                              |  6 +++++-
 testcases/kernel/syscalls/ustat/ustat01.c | 14 ++++++++++++--
 testcases/kernel/syscalls/ustat/ustat02.c | 10 +++++++++-
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index 465655e7b..17a02050a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -44,9 +44,13 @@ AC_CHECK_HEADERS([ \
     sys/inotify.h \
     sys/fanotify.h \
     sys/prctl.h \
+    sys/ustat.h \
 ])
 
-AC_CHECK_FUNCS([profil])
+AC_CHECK_FUNCS([ \
+    profil \
+    ustat \
+])
 
 # Tools knobs
 
diff --git a/testcases/kernel/syscalls/ustat/ustat01.c b/testcases/kernel/syscalls/ustat/ustat01.c
index 494647bc2..74a880577 100644
--- a/testcases/kernel/syscalls/ustat/ustat01.c
+++ b/testcases/kernel/syscalls/ustat/ustat01.c
@@ -21,15 +21,19 @@
 
 #include <unistd.h>
 #include <errno.h>
-#include <sys/ustat.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include "test.h"
 #include "safe_macros.h"
+#include "config.h"
+
+char *TCID = "ustat01";
+
+#if defined(HAVE_SYS_USTAT_H) && defined(HAVE_USTAT)
+#include <sys/ustat.h>
 
 static void setup(void);
 
-char *TCID = "ustat01";
 int TST_TOTAL = 1;
 
 static dev_t dev_num;
@@ -79,3 +83,9 @@ static void setup(void)
 
 	dev_num = buf.st_dev;
 }
+#else /* systems without ustat() */
+int main(void)
+{
+	tst_brkm(TCONF, NULL, "system doesn't have ustat() support");
+}
+#endif
diff --git a/testcases/kernel/syscalls/ustat/ustat02.c b/testcases/kernel/syscalls/ustat/ustat02.c
index edada3107..cb2f0b828 100644
--- a/testcases/kernel/syscalls/ustat/ustat02.c
+++ b/testcases/kernel/syscalls/ustat/ustat02.c
@@ -22,12 +22,14 @@
 
 #include <unistd.h>
 #include <errno.h>
-#include <sys/ustat.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include "test.h"
 #include "safe_macros.h"
 
+#if defined(HAVE_SYS_USTAT_H) && defined(HAVE_USTAT)
+#include <sys/ustat.h>
+
 static void setup(void);
 
 char *TCID = "ustat02";
@@ -101,3 +103,9 @@ static void setup(void)
 
 	root_dev = buf.st_dev;
 }
+#else /* systems without ustat() */
+int main(void)
+{
+	tst_brkm(TCONF, NULL, "system doesn't have ustat() support");
+}
+#endif
-- 
2.14.2

