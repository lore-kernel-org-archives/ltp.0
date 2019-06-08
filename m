From: Li Wang <liwang@redhat.com>
Date: Sat,  8 Jun 2019 13:45:50 +0800
Subject: [LTP] [PATCH RFC 3/3] testcase: get rid of compiling errors
In-Reply-To: <20190608054550.13744-1-liwang@redhat.com>
References: <20190608054550.13744-1-liwang@redhat.com>
Message-ID: <20190608054550.13744-3-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 configure.ac             | 1 +
 testcases/cve/meltdown.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/configure.ac b/configure.ac
index 5a3dc5b62..39b2d6da7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -58,6 +58,7 @@ AC_CHECK_HEADERS([ \
     sys/shm.h \
     sys/ustat.h \
     sys/xattr.h \
+    emmintrin.h \
 ])
 
 AC_CHECK_FUNCS([ \
diff --git a/testcases/cve/meltdown.c b/testcases/cve/meltdown.c
index da35213ec..e6e911fcc 100644
--- a/testcases/cve/meltdown.c
+++ b/testcases/cve/meltdown.c
@@ -29,6 +29,7 @@
 #include <ctype.h>
 #include <sys/utsname.h>
 
+#ifdef HAVE_EMMINTRIN_H
 #include <emmintrin.h>
 
 #include "libtsc.h"
@@ -387,3 +388,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.min_kver = "2.6.32"
 };
+
+#else /* HAVE_EMMINTRIN_H */
+	TST_TEST_TCONF("<emmintrin.h> is not supported");
+#endif
-- 
2.17.0

