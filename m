From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 15 Apr 2020 11:28:02 +0200
Subject: [LTP] [RFC PATCH 1/8] lib: Fix linking error multiple TCID
 definitions with -fno-common
In-Reply-To: <20200415092809.20240-1-pvorel@suse.cz>
References: <20200415092809.20240-1-pvorel@suse.cz>
Message-ID: <20200415092809.20240-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

-fno-common is a default for gcc-10 and if not used on many targets
implies a speed and code size penalty on global variable references.
It requires either defining variable in header as extern or moving it
to C source.

https://gcc.gnu.org/gcc-10/porting_to.html

Due different TCID handling in legacy API (which defines TCID in the
test source) and new API (TCID defined in the library header) it's not
enough to simply move that definition into tst_test.c because that would
mean that old API test would end up with multiple definitions one in the
corresponding test and one in the new library library code. To workaround
this added definition in tst_test.c with weak linker attribute.

Keeping TCID as extern in tst_test.h is needed because it's used in some
new API tests (e.g. CHECK_MFD_NEW() in memfd_create01.c).

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_test.h | 6 ++----
 lib/tst_test.c     | 5 +++++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index 42c02b549..fa54f9cde 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -319,9 +319,7 @@ int main(int argc, char *argv[])
 
 #define TST_TEST_TCONF(message)                                 \
         static struct tst_test test = { .tconf_msg = message  } \
-/*
- * This is a hack to make the testcases link without defining TCID
- */
-const char *TCID;
+
+extern const char *TCID;
 
 #endif	/* TST_TEST_H__ */
diff --git a/lib/tst_test.c b/lib/tst_test.c
index e502c2c1a..64cd3ac33 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -32,6 +32,11 @@
 #include "old_device.h"
 #include "old_tmpdir.h"
 
+/*
+ * Hack to get TCID defined in newlib tests
+ */
+const char *TCID __attribute__((weak));
+
 #define LINUX_GIT_URL "https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id="
 #define CVE_DB_URL "https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-"
 
-- 
2.26.0

