From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 22 Sep 2020 16:42:37 +0200
Subject: [LTP] [PATCH 1/1] tst_test.sh: More readable syntax
Message-ID: <20200922144237.9865-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

"for cmd; do" works the same way as "for cmd in $*; do", but the latter
is more readable. Also sync the code with tst_require_cmds().

Fixes: dba1d50cb ("tst_test.sh: Add test cmd helper tst_check_cmds()")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index fa97acbac..f2bd1e3ef 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -350,7 +350,7 @@ tst_require_cmds()
 tst_check_cmds()
 {
 	local cmd
-	for cmd; do
+	for cmd in $*; do
 		if ! tst_cmd_available $cmd; then
 			tst_res TCONF "'$cmd' not found"
 			return 1
-- 
2.28.0

