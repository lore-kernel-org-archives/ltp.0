From: Petr Cervinka <pcervinka@suse.com>
Date: Tue,  4 Jun 2019 11:08:24 +0200
Subject: [LTP] [PATCH v2] Fix shebang in open-posix makefile generator
Message-ID: <20190604090824.15427-1-pcervinka@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

---
 testcases/open_posix_testsuite/scripts/generate-makefiles.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/open_posix_testsuite/scripts/generate-makefiles.sh b/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
index 4666739f5..7b11c98bd 100755
--- a/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
+++ b/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
@@ -186,7 +186,7 @@ EOF
 	if ! grep -q '^run.sh' "$makefile.3"; then
 		cat >> "$makefile.3" <<EOF
 run.sh:
-	@echo '#/bin/sh' > \$@
+	@echo '#!/bin/sh' > \$@
 	@echo "\$(top_srcdir)/bin/run-tests.sh \$(subdir) \$(INSTALL_TARGETS)" >> \$@
 	@chmod +x run.sh
 
-- 
2.16.4

