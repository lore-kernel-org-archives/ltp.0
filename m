From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 18 Jul 2017 16:24:59 +0200
Subject: [LTP] [PATCH v2 1/2] lib/test.sh: Remove temporary directory only
	if we know the location
Message-ID: <20170718142500.2725-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is a problem when a test TCONF before calling tst_tmpdir, but has
tst_rmdir in cleanup function (e.g. dhcp_lib.sh when failing on
tst_check_cmds).

Now it has the same behaviour as deleting $TST_TMPDIR in tst_do_exit
in tst_test.sh.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Ping old commit:
Changes v1->v2: just commit message.
---
 testcases/lib/test.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index 642f7eacf..d16444efa 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -132,8 +132,10 @@ tst_tmpdir()
 
 tst_rmdir()
 {
-	cd "$LTPROOT"
-	rm -r "$TST_TMPDIR"
+	if [ -n "$TST_TMPDIR" ]; then
+		cd "$LTPROOT"
+		rm -r "$TST_TMPDIR"
+	fi
 }
 
 #
-- 
2.13.2

