From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  5 Apr 2019 18:52:23 +0200
Subject: [LTP] [PATCH v2 1/3] ima: Call test's cleanup inside ima_setup.sh
	cleanup
In-Reply-To: <20190405165225.27216-1-pvorel@suse.cz>
References: <20190405165225.27216-1-pvorel@suse.cz>
Message-ID: <20190405165225.27216-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

to work the same way as setup

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/security/integrity/ima/tests/ima_setup.sh  | 6 +++++-
 .../kernel/security/integrity/ima/tests/ima_violations.sh   | 2 --
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 52551190a..cbded42c2 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -20,7 +20,8 @@
 TST_TESTFUNC="test"
 TST_SETUP_CALLER="$TST_SETUP"
 TST_SETUP="ima_setup"
-TST_CLEANUP="${TST_CLEANUP:-ima_cleanup}"
+TST_CLEANUP_CALLER="$TST_CLEANUP"
+TST_CLEANUP="ima_cleanup"
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_ROOT=1
 
@@ -95,6 +96,9 @@ ima_setup()
 ima_cleanup()
 {
 	local dir
+
+	[ -n "$TST_CLEANUP_CALLER" ] && $TST_CLEANUP_CALLER
+
 	for dir in $UMOUNT; do
 		umount $dir
 	done
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index 74223c221..a44bd1230 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -51,8 +51,6 @@ cleanup()
 {
 	[ "$PRINTK_RATE_LIMIT" != "0" ] && \
 		sysctl -wq kernel.printk_ratelimit=$PRINTK_RATE_LIMIT
-
-	ima_cleanup
 }
 
 open_file_read()
-- 
2.21.0

