From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 22 Jun 2018 17:10:41 +0200
Subject: [LTP] [PATCH v2 2/8] tst_test.sh: Introduce TST_LIB_LOADED
In-Reply-To: <20180622151047.13002-1-pvorel@suse.cz>
References: <20180622151047.13002-1-pvorel@suse.cz>
Message-ID: <20180622151047.13002-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This allows to detect whether library was loaded more than once.
This is used by tst_net.sh (which is loaded more than once itself
by tests macsec0{1,2}.sh).

+ We don't waste time with multiple loading the library.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/lib/tst_test.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index d27b4afd6..e07d956ea 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -21,6 +21,8 @@
 # This is a LTP test library for shell.
 #
 
+[ -n "$TST_LIB_LOADED" ] && return 0
+
 export TST_PASS=0
 export TST_FAIL=0
 export TST_BROK=0
@@ -29,6 +31,7 @@ export TST_CONF=0
 export TST_COUNT=1
 export TST_ITERATIONS=1
 export TST_TMPDIR_RHOST=0
+export TST_LIB_LOADED=1
 
 . tst_ansi_color.sh
 
-- 
2.17.1

