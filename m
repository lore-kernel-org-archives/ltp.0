From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  6 Oct 2017 03:53:34 +0200
Subject: [LTP] [RFC PATCH 4/6] m4: Fix libcrypto detection on 32-bit cross
	build
In-Reply-To: <20171006015336.29972-1-pvorel@suse.cz>
References: <20171006015336.29972-1-pvorel@suse.cz>
Message-ID: <20171006015336.29972-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 configure.ac                                            |  7 ++++---
 m4/ltp-crypto.m4                                        | 10 ++++++----
 .../security/integrity/ima/src/ima_boot_aggregate.c     | 13 +++++++++----
 .../kernel/security/integrity/ima/src/ima_measure.c     | 17 ++++++++---------
 4 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/configure.ac b/configure.ac
index 56fc9248e..43282cfeb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -33,14 +33,15 @@ AC_PREFIX_DEFAULT(/opt/ltp)
 AC_CHECK_HEADERS([ \
     ifaddrs.h \
     libaio.h \
-    mm.h \
-    pthread.h \
-    sys/xattr.h \
     linux/can.h \
     linux/genetlink.h \
     linux/mempolicy.h \
     linux/module.h \
     linux/netlink.h \
+    mm.h \
+    openssl/sha.h \
+    pthread.h \
+    sys/xattr.h \
     sys/epoll.h \
     sys/inotify.h \
     sys/fanotify.h \
diff --git a/m4/ltp-crypto.m4 b/m4/ltp-crypto.m4
index 3dfc51266..d066ab7e0 100644
--- a/m4/ltp-crypto.m4
+++ b/m4/ltp-crypto.m4
@@ -2,8 +2,10 @@ dnl
 dnl LTP_CHECK_CRYPTO
 dnl ----------------------------
 dnl
-AC_DEFUN([LTP_CHECK_CRYPTO],
-[dnl
-AC_CHECK_HEADERS(openssl/sha.h,[CRYPTO_LIBS=-lcrypto],[CRYPTO_LIBS=])
-AC_SUBST(CRYPTO_LIBS)
+AC_DEFUN([LTP_CHECK_CRYPTO], [
+	AC_CHECK_LIB([crypto], [SHA1_Init], [crypto_libs="-lcrypto"])
+	AC_SUBST([CRYPTO_LIBS], [$crypto_libs])
+	if test "x$have_libnuma" != "x"; then
+		AC_DEFINE(HAVE_LIBCRYPTO,1,[define whether libcrypto is installed])
+	fi
 ])
diff --git a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
index f67eb684b..9f500553c 100644
--- a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
+++ b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
@@ -29,6 +29,8 @@
 #include <openssl/sha.h>
 #endif
 
+#if HAVE_LIBCRYPTO && HAVE_OPENSSL_SHA_H
+
 #define MAX_EVENT_SIZE 500
 #define EVENT_HEADER_SIZE 32
 #define MAX_EVENT_DATA_SIZE (MAX_EVENT_SIZE - EVENT_HEADER_SIZE)
@@ -48,7 +50,6 @@ static void display_sha1_digest(unsigned char *pcr)
 
 int main(int argc, char *argv[])
 {
-#if HAVE_OPENSSL_SHA_H
 	unsigned char boot_aggregate[SHA_DIGEST_LENGTH];
 	struct {
 		struct {
@@ -113,8 +114,12 @@ int main(int argc, char *argv[])
 
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
index 61851a36a..7c37b7c20 100644
--- a/testcases/kernel/security/integrity/ima/src/ima_measure.c
+++ b/testcases/kernel/security/integrity/ima/src/ima_measure.c
@@ -28,6 +28,7 @@
 #include <openssl/sha.h>
 #endif
 
+#if HAVE_LIBCRYPTO && HAVE_OPENSSL_SHA_H
 #define TCG_EVENT_NAME_LEN_MAX	255
 
 char *TCID = "ima_measure";
@@ -39,8 +40,6 @@ static int verbose;
 	if (verbose) \
 		printf(format, ##arg)
 
-#if HAVE_OPENSSL_SHA_H
-
 static u_int8_t zero[SHA_DIGEST_LENGTH];
 static u_int8_t fox[SHA_DIGEST_LENGTH];
 
@@ -97,8 +96,6 @@ static int verify_template_hash(struct event *template)
 	return 0;
 }
 
-#endif
-
 /*
  * ima_measurements.c - calculate the SHA1 aggregate-pcr value based
  * on the IMA runtime binary measurements.
@@ -131,8 +128,6 @@ static int verify_template_hash(struct event *template)
  */
 int main(int argc, char *argv[])
 {
-
-#if HAVE_OPENSSL_SHA_H
 	FILE *fp;
 	struct event template;
 	u_int8_t pcr[SHA_DIGEST_LENGTH];
@@ -212,8 +207,12 @@ int main(int argc, char *argv[])
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

