From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 11 Oct 2017 15:53:33 +0200
Subject: [LTP] [PATCH v2 1/1] syscalls/ustat: Fix build for libc without
	ustat() support
Message-ID: <20171011135333.17173-1-pvorel@suse.cz>
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
 configure.ac                              |  6 +++++-
 testcases/kernel/syscalls/ustat/ustat01.c | 17 +++++++++++++++--
 testcases/kernel/syscalls/ustat/ustat02.c | 18 +++++++++++++++---
 3 files changed, 35 insertions(+), 6 deletions(-)

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
index 494647bc2..31d7f86dc 100644
--- a/testcases/kernel/syscalls/ustat/ustat01.c
+++ b/testcases/kernel/syscalls/ustat/ustat01.c
@@ -21,15 +21,22 @@
 
 #include <unistd.h>
 #include <errno.h>
-#include <sys/ustat.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+
+#include "config.h"
 #include "test.h"
 #include "safe_macros.h"
 
+char *TCID = "ustat01";
+
+#ifdef HAVE_USTAT
+# ifdef HAVE_SYS_USTAT_H
+#  include <sys/ustat.h>
+# endif
+
 static void setup(void);
 
-char *TCID = "ustat01";
 int TST_TOTAL = 1;
 
 static dev_t dev_num;
@@ -79,3 +86,9 @@ static void setup(void)
 
 	dev_num = buf.st_dev;
 }
+#else
+int main(void)
+{
+	tst_brkm(TCONF, NULL, "system doesn't have ustat() support");
+}
+#endif
diff --git a/testcases/kernel/syscalls/ustat/ustat02.c b/testcases/kernel/syscalls/ustat/ustat02.c
index edada3107..fe644f9a9 100644
--- a/testcases/kernel/syscalls/ustat/ustat02.c
+++ b/testcases/kernel/syscalls/ustat/ustat02.c
@@ -22,16 +22,22 @@
 
 #include <unistd.h>
 #include <errno.h>
-#include <sys/ustat.h>
 #include <sys/stat.h>
 #include <sys/types.h>
+
+#include "config.h"
 #include "test.h"
 #include "safe_macros.h"
 
-static void setup(void);
-
 char *TCID = "ustat02";
 
+#ifdef HAVE_USTAT
+# ifdef HAVE_SYS_USTAT_H
+#  include <sys/ustat.h>
+# endif
+
+static void setup(void);
+
 static dev_t invalid_dev = -1;
 static dev_t root_dev;
 struct ustat ubuf;
@@ -101,3 +107,9 @@ static void setup(void)
 
 	root_dev = buf.st_dev;
 }
+#else
+int main(void)
+{
+	tst_brkm(TCONF, NULL, "system doesn't have ustat() support");
+}
+#endif
-- 
2.14.2

