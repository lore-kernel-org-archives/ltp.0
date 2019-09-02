From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  2 Sep 2019 15:42:13 +0200
Subject: [LTP] [COMMITTED][PATCH] tst_net.sh: Fix unintended
 tst_require_root call in shell new API
Message-ID: <20190902134213.545-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

for cases where tst_require_root_ is called by root (by evaluating ||):
/opt/ltp/testcases/bin/tst_net.sh: line 102: tst_require_root: command not found

NOTE: 4552972e5 ("tst_test.sh: Always return 0 from
_tst_require_root()") was intended to fix it, but it didn't.

Fixes: 8722680b6 ("tst_net.sh: Use _tst_require_root instead of TST_NEEDS_ROOT=1")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

sorry for useless 4552972e5 commit.

Kind regards,
Petr

 testcases/lib/tst_net.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 6a9d51b81..6c3ae708d 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -99,7 +99,11 @@ tst_brk_()
 }
 tst_require_root_()
 {
-	[ -z "$TST_USE_LEGACY_API" ] && _tst_require_root || tst_require_root
+	if [ -z "$TST_USE_LEGACY_API" ]; then
+		_tst_require_root
+	else
+		tst_require_root
+	fi
 }
 
 init_ltp_netspace()
-- 
2.22.1

