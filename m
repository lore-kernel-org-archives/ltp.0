From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 12 Oct 2017 20:33:26 +0200
Subject: [LTP] [PATCH v3 09/18] m4: Fix libcrypto detection on 32-bit cross
	build
In-Reply-To: <20171012183335.24568-1-pvorel@suse.cz>
References: <20171012183335.24568-1-pvorel@suse.cz>
Message-ID: <20171012183335.24568-10-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We check not only for openssl/sha.h but also for libcrypto.so.
Check are added in m4 so to simplify #if checks in C sources.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 m4/ltp-crypto.m4                                   | 11 ++++++----
 .../integrity/ima/src/ima_boot_aggregate.c         | 21 +++++++++++--------
 .../security/integrity/ima/src/ima_measure.c       | 24 +++++++++++-----------
 3 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/m4/ltp-crypto.m4 b/m4/ltp-crypto.m4
index 3dfc51266..c0c65e0cd 100644
--- a/m4/ltp-crypto.m4
+++ b/m4/ltp-crypto.m4
@@ -2,8 +2,11 @@ dnl
 dnl LTP_CHECK_CRYPTO
 dnl ----------------------------
 dnl
-AC_DEFUN([LTP_CHECK_CRYPTO],
-[dnl
-AC_CHECK_HEADERS(openssl/sha.h,[CRYPTO_LIBS=-lcrypto],[CRYPTO_LIBS=])
-AC_SUBST(CRYPTO_LIBS)
+AC_DEFUN([LTP_CHECK_CRYPTO], [
+	AC_CHECK_LIB([crypto], [SHA1_Init], [have_libcrypto=yes], [AC_MSG_WARN(missing libcrypto)])
+	AC_CHECK_HEADERS([openssl/sha.h], [have_sha=yes], [AC_MSG_WARN(missing openssl headers)])
+	if test "x$have_libcrypto" = "xyes" -a "x$have_sha" = "xyes"; then
+		AC_DEFINE(HAVE_LIBCRYPTO, 1, [Define whether libcrypto and openssl headers are installed])
+		AC_SUBST(CRYPTO_LIBS, "-lcrypto")
+	fi
 ])
diff --git a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
index f67eb684b..d8e08928b 100644
--- a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
+++ b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
@@ -13,8 +13,6 @@
 *
 * Calculate a SHA1 boot aggregate value based on the TPM
 * binary_bios_measurements.
-*
-* Requires openssl; compile with -lcrypto option
 */
 #include <stdio.h>
 #include <stdlib.h>
@@ -23,18 +21,20 @@
 #include <fcntl.h>
 #include <string.h>
 #include <unistd.h>
+
 #include "config.h"
 #include "test.h"
-#if HAVE_OPENSSL_SHA_H
+
+char *TCID = "ima_boot_aggregate";
+
+#if HAVE_LIBCRYPTO
 #include <openssl/sha.h>
-#endif
 
 #define MAX_EVENT_SIZE 500
 #define EVENT_HEADER_SIZE 32
 #define MAX_EVENT_DATA_SIZE (MAX_EVENT_SIZE - EVENT_HEADER_SIZE)
 #define NUM_PCRS 8		/*  PCR registers 0-7 in boot aggregate */
 
-char *TCID = "ima_boot_aggregate";
 int TST_TOTAL = 1;
 
 static void display_sha1_digest(unsigned char *pcr)
@@ -48,7 +48,6 @@ static void display_sha1_digest(unsigned char *pcr)
 
 int main(int argc, char *argv[])
 {
-#if HAVE_OPENSSL_SHA_H
 	unsigned char boot_aggregate[SHA_DIGEST_LENGTH];
 	struct {
 		struct {
@@ -113,8 +112,12 @@ int main(int argc, char *argv[])
 
 	printf("boot_aggregate:");
 	display_sha1_digest(boot_aggregate);
-#else
-	tst_resm(TCONF, "System doesn't have openssl/sha.h");
-#endif
 	tst_exit();
 }
+
+#else
+int main(void)
+{
+	tst_resm(TCONF, "test requires libcrypto and openssl development packages");
+}
+#endif
diff --git a/testcases/kernel/security/integrity/ima/src/ima_measure.c b/testcases/kernel/security/integrity/ima/src/ima_measure.c
index 61851a36a..673e6ab2a 100644
--- a/testcases/kernel/security/integrity/ima/src/ima_measure.c
+++ b/testcases/kernel/security/integrity/ima/src/ima_measure.c
@@ -22,15 +22,17 @@
 #include <fcntl.h>
 #include <string.h>
 #include <unistd.h>
+
 #include "config.h"
 #include "test.h"
-#if HAVE_OPENSSL_SHA_H
+
+char *TCID = "ima_measure";
+
+#if HAVE_LIBCRYPTO
 #include <openssl/sha.h>
-#endif
 
 #define TCG_EVENT_NAME_LEN_MAX	255
 
-char *TCID = "ima_measure";
 int TST_TOTAL = 1;
 
 static int verbose;
@@ -39,8 +41,6 @@ static int verbose;
 	if (verbose) \
 		printf(format, ##arg)
 
-#if HAVE_OPENSSL_SHA_H
-
 static u_int8_t zero[SHA_DIGEST_LENGTH];
 static u_int8_t fox[SHA_DIGEST_LENGTH];
 
@@ -97,8 +97,6 @@ static int verify_template_hash(struct event *template)
 	return 0;
 }
 
-#endif
-
 /*
  * ima_measurements.c - calculate the SHA1 aggregate-pcr value based
  * on the IMA runtime binary measurements.
@@ -131,8 +129,6 @@ static int verify_template_hash(struct event *template)
  */
 int main(int argc, char *argv[])
 {
-
-#if HAVE_OPENSSL_SHA_H
 	FILE *fp;
 	struct event template;
 	u_int8_t pcr[SHA_DIGEST_LENGTH];
@@ -212,8 +208,12 @@ int main(int argc, char *argv[])
 	verbose = 1;
 	print_info("PCRAggr (re-calculated):");
 	display_sha1_digest(pcr);
-#else
-	tst_resm(TCONF, "System doesn't have openssl/sha.h");
-#endif
 	tst_exit();
 }
+
+#else
+int main(void)
+{
+	tst_resm(TCONF, "test requires libcrypto and openssl development packages");
+}
+#endif
-- 
2.14.2

