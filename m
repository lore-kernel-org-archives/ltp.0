From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 26 Jun 2020 12:05:37 +0200
Subject: [LTP] [PATCH] [COMMITTED] libltpvdso: Add check for getauxval()
Message-ID: <20200626100537.23511-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The getauxval() function have been added into glibc 2.19 and hence is
not present in Centos 6.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 configure.ac                   | 1 +
 libs/libltpvdso/vdso_helpers.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/configure.ac b/configure.ac
index 05032d1cf..81804fd5b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -87,6 +87,7 @@ AC_CHECK_FUNCS([ \
     fsopen \
     fspick \
     fstatat \
+    getauxval \
     getdents \
     getdents64 \
     io_pgetevents \
diff --git a/libs/libltpvdso/vdso_helpers.c b/libs/libltpvdso/vdso_helpers.c
index e95840345..635270097 100644
--- a/libs/libltpvdso/vdso_helpers.c
+++ b/libs/libltpvdso/vdso_helpers.c
@@ -9,11 +9,13 @@
 
 #include "parse_vdso.h"
 #include <sys/auxv.h>
+#include "config.h"
 
 static unsigned long sysinfo_ehdr;
 
 static void vdso_init(void)
 {
+#ifdef HAVE_GETAUXVAL
 	if (sysinfo_ehdr)
 		return;
 
@@ -24,6 +26,9 @@ static void vdso_init(void)
 	}
 
 	vdso_init_from_sysinfo_ehdr(sysinfo_ehdr);
+#else
+	tst_res(TINFO, "getauxval() not supported");
+#endif /* HAVE_GETAUXVAL */
 }
 
 void find_clock_gettime_vdso(gettime_t *ptr_vdso_gettime,
-- 
2.26.2

