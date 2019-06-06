From: Petr Cervinka <pcervinka@suse.com>
Date: Thu,  6 Jun 2019 10:32:47 +0200
Subject: [LTP] [PATCH v3] Fix shebang in open-posix makefile generator
Message-ID: <20190606083247.6848-1-pcervinka@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Cervinka <pcervinka@suse.com>
---
Changes v2-v3:
  * Sign commit
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

