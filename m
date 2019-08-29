From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 30 Aug 2019 00:50:29 +0200
Subject: [LTP] [COMMITTED][PATCH] tst_test.sh: Always return 0 from
 _tst_require_root()
Message-ID: <20190829225029.29506-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

8722680b6 ("tst_net.sh: Use _tst_require_root instead of TST_NEEDS_ROOT=1")
is broken _tst_require_root() returns non zero value therefore
tst_require_root() is called as well:

/opt/ltp/testcases/bin/if4-addr-change.sh: 102: /opt/ltp/testcases/bin/tst_net.sh: tst_require_root: not found

While code should not expect functions returning always zero, in this
case it's an unwanted side effect, therefore fix it by wrapping
_tst_require_root() code with if clause.

Fixes: e7b804df6 ("shell: Add tst_security.sh helper")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

sorry for this old bug and for overlooking this error in tst_net.sh
change.

Kind regards,
Petr

 testcases/lib/tst_test.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index f779cc471..e0b24c6b9 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -391,7 +391,9 @@ _tst_setup_timer()
 
 _tst_require_root()
 {
-	[ "$(id -ru)" != 0 ] && tst_brk TCONF "Must be super/root for this test!"
+	if [ "$(id -ru)" != 0 ]; then
+		tst_brk TCONF "Must be super/root for this test!"
+	fi
 }
 
 tst_run()
-- 
2.22.1

