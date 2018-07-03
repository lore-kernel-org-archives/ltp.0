From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  3 Jul 2018 09:42:02 +0200
Subject: [LTP] [PATCH v3 2/9] tst_test.sh: Introduce TST_LIB_LOADED
In-Reply-To: <20180703074209.911-1-pvorel@suse.cz>
References: <20180703074209.911-1-pvorel@suse.cz>
Message-ID: <20180703074209.911-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

to load the library only once.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Acked-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/lib/tst_test.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 73c238ab4..c2460762d 100644
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
2.18.0

