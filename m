From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 24 Aug 2021 20:13:38 +0200
Subject: [LTP] [PATCH 1/1] openposix: Support VERBOSE mode
Message-ID: <20210824181338.19034-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

i.e. VERBOSE=1 or V=1 to print gcc output.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../scripts/generate-makefiles.sh                     | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/testcases/open_posix_testsuite/scripts/generate-makefiles.sh b/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
index 4b3aaa4a0..e3bd5bfbc 100755
--- a/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
+++ b/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
@@ -156,6 +156,13 @@ EOF
 	cat >> "$makefile.2" <<EOF
 MAKE_TARGETS+=		${targets}
 
+ifeq (\$V,1)
+VERBOSE=1
+endif
+ifndef VERBOSE
+v=@
+endif
+
 EOF
 
 	if [ ! -f "$makefile.3" ]; then
@@ -178,7 +185,7 @@ install: \$(INSTALL_DIR) run.sh
 	@if [ -d speculative ]; then \$(MAKE) -C speculative install; fi
 
 test: run.sh
-	@./run.sh
+	\$(v)./run.sh
 
 \$(INSTALL_DIR):
 	mkdir -p \$@
@@ -231,7 +238,7 @@ EOF
 
 		cat >> "$makefile.3" <<EOF
 $bin_file: \$(srcdir)/$c_file
-	@if $COMPILE_STR > logfile.\$\$\$\$ 2>&1; then \\
+	\$(v)if $COMPILE_STR > logfile.\$\$\$\$ 2>&1; then \\
 		 cat logfile.\$\$\$\$; \\
 		 echo "\$(subdir)/$test_name compile PASSED"; \\
 		 echo "\$(subdir)/$test_name compile PASSED" >> \$(LOGFILE); \\
-- 
2.32.0

