From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 20 Apr 2016 18:23:53 +0200
Subject: [LTP] [PATCH] open_posix_testsuite: Propagate configure params
Message-ID: <20160420162353.GA28307@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The open_posix_testsuite can be enabled to build from the top level
configure but none of the parameters passed to it are propagated which
confuses users and has been discussed a few times on the LTP ML.

This commit propagates CC, CFLAGS and LDFLAGS. If config-openposix.mk
was created by the top level configure script the generate-makefiles.sh
script includes its content in the generated Makefiles.

This fixes issue #54.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .gitignore                                                   | 1 +
 configure.ac                                                 | 1 +
 include/mk/config-openposix.mk.in                            | 5 +++++
 testcases/open_posix_testsuite/scripts/generate-makefiles.sh | 7 ++++++-
 4 files changed, 13 insertions(+), 1 deletion(-)
 create mode 100644 include/mk/config-openposix.mk.in

diff --git a/.gitignore b/.gitignore
index 06acb20..1b4ac3e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -32,6 +32,7 @@ autom4te.cache
 /README.ltp-devel
 /Version
 /include/mk/config.mk
+/include/mk/config-openposix.mk
 /include/mk/features.mk
 /m4/ltp-version.m4
 /lib/ltp.pc
diff --git a/configure.ac b/configure.ac
index 87e006d..e0e9c1b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -6,6 +6,7 @@ AC_CONFIG_HEADERS([include/config.h])
 AC_CONFIG_MACRO_DIR([m4])
 AC_CONFIG_FILES([ \
     include/mk/config.mk \
+    include/mk/config-openposix.mk \
     include/mk/features.mk \
     lib/ltp.pc \
     m4/Makefile \
diff --git a/include/mk/config-openposix.mk.in b/include/mk/config-openposix.mk.in
new file mode 100644
index 0000000..9a91dcb
--- /dev/null
+++ b/include/mk/config-openposix.mk.in
@@ -0,0 +1,5 @@
+# Parameters from the top level configure
+CC=		@CC@
+CFLAGS+=	@CFLAGS@
+LDLIBS+=	@LIBS@
+LDFLAGS+=	@LDFLAGS@
diff --git a/testcases/open_posix_testsuite/scripts/generate-makefiles.sh b/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
index 8a743fa..f118712 100755
--- a/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
+++ b/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
@@ -27,7 +27,6 @@ generate_locate_test_makefile() {
 	generate_makefiles make-gen.$maketype $*
 
 	rm -f make-gen.$maketype
-
 }
 
 generate_makefile() {
@@ -290,6 +289,8 @@ TOP_SRCDIR=${TOP_SRCDIR:=`dirname "$0"`/..}
 
 GLOBAL_BOILERPLATE="${TOP_SRCDIR}/.global_boilerplate"
 
+CONFIG_MK="../../include/mk/config-openposix.mk"
+
 rm -f "$GLOBAL_BOILERPLATE"
 
 for var in CFLAGS LDFLAGS LDLIBS; do
@@ -300,6 +301,10 @@ EOF
 	fi
 done
 
+if [ -f "$CONFIG_MK" ]; then
+	cat "$CONFIG_MK" >> "$GLOBAL_BOILERPLATE"
+fi
+
 # For the generic cases.
 generate_locate_test_makefile buildonly '.test' '-c'
 generate_locate_test_makefile runnable '.run-test'
-- 
2.4.10


-- 
Cyril Hrubis
chrubis@suse.cz
